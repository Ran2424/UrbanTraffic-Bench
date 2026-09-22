"""Validate the active UrbanTraffic-Bench release without modifying files."""

from collections import Counter
import hashlib
import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


def read_json(path):
    return json.loads(path.read_text(encoding="utf-8"))


def read_jsonl(path):
    return [
        json.loads(line)
        for line in path.read_text(encoding="utf-8-sig").splitlines()
        if line.strip()
    ]


def sha256(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def validate_refs(tasks):
    for task in tasks:
        for field in ("schema_ref", "schema_markdown_ref", "knowledge_ref", "result_ref"):
            relative = task.get(field)
            if relative:
                assert (ROOT / relative).is_file(), f"Missing {field}: {relative}"


def validate_tasks():
    tasks_path = ROOT / "tasks/tasks.jsonl"
    tasks = read_jsonl(tasks_path)
    summary = read_json(ROOT / "metadata/benchmark_summary.json")
    expected_ids = (
        [f"S{index:02d}" for index in range(1, 41)]
        + [f"X{index:02d}" for index in range(1, 31)]
        + [f"G{index:02d}" for index in range(1, 31)]
    )
    assert [task["task_id"] for task in tasks] == expected_ids
    assert len(tasks) == 100 == summary["task_count"]
    assert Counter(task["scenario_zh"] for task in tasks) == {
        "单方式查询": 40,
        "多方式联合查询": 30,
        "GIS空间关联查询": 30,
    }
    assert Counter(task["difficulty"] for task in tasks) == {
        "简": 12,
        "中": 40,
        "难": 48,
    }
    assert all(task["execution_status"] == "ok" for task in tasks)
    assert all(task["supplementary_notes"] for task in tasks)
    assert all(task["output_contract"]["columns"] for task in tasks)
    assert all(task["review_status"] == "pending_two_person_review" for task in tasks)
    assert sha256(tasks_path) == "9a6100b41a016daa8adfdd61d131d1c1679e79072fe7cb5af94fd5fa4ae27ebd"
    validate_refs(tasks)

    for task in tasks:
        result_path = ROOT / task["result_ref"]
        sql_path = ROOT / "sql" / f"{task['task_id']}.sql"
        assert sql_path.is_file(), f"Missing SQL: {task['task_id']}"
        assert sql_path.read_text(encoding="utf-8").strip() == task["gold_sql"].strip()
        result = read_json(result_path)
        assert result["task_id"] == task["task_id"]
        assert result["execution_status"] == "ok"
        assert result["row_count"] > 0

    return {
        "tasks": len(tasks),
        "categories": summary["categories"],
        "difficulty": summary["difficulty"],
        "review_status": summary["review_status"],
    }


def validate_database():
    database = read_json(ROOT / "metadata/database.json")
    archive = ROOT / database["archive_ref"]
    assert archive.stat().st_size == database["archive_size_bytes"]
    assert sha256(archive) == database["archive_sha256"]
    return {
        "databases": 1,
        "archive_sha256": database["archive_sha256"],
        "database_sha256": database["database_sha256"],
    }


def validate_baseline():
    baseline_path = ROOT / "baselines/four_models_v2/complete_evaluation_data.json"
    baseline = read_json(baseline_path)
    scope = baseline["scope"]
    assert scope["task_count"] == 100
    assert scope["model_count"] == 4
    assert scope["method_count"] == 2
    assert scope["evaluation_count"] == len(baseline["evaluations"]) == 800
    assert set(scope["methods"]) == {"Text2SQL", "TransportX Agent"}
    assert len({item["evaluation_id"] for item in baseline["evaluations"]}) == 800
    return {
        "models": scope["model_count"],
        "methods": scope["method_count"],
        "evaluations": scope["evaluation_count"],
    }


def validate_archive():
    archive_root = ROOT / "archive/open_source_sql"
    summary = read_json(archive_root / "metadata/benchmark_summary.json")
    tasks = read_jsonl(archive_root / "tasks/tasks.jsonl")
    databases = read_jsonl(archive_root / "metadata/databases.jsonl")
    assert len(tasks) == summary["task_count"] == 1696
    assert len(databases) == summary["database_count"] == 27
    return {"tasks": len(tasks), "databases": len(databases), "active": False}


def main():
    benchmark = read_json(ROOT / "metadata/benchmark.json")
    assert benchmark["benchmark_name"] == "UrbanTraffic-Bench"
    assert benchmark["task_count"] == 100
    assert benchmark["database_count"] == 1
    print(
        json.dumps(
            {
                "status": "passed",
                "benchmark": benchmark["benchmark_name"],
                "version": benchmark["release_version"],
                "active_release": {
                    **validate_tasks(),
                    **validate_database(),
                    "baseline": validate_baseline(),
                },
                "archive": {"open_source_sql": validate_archive()},
            },
            ensure_ascii=False,
            indent=2,
        )
    )


if __name__ == "__main__":
    main()
