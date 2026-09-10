"""Validate the two-track TrafficSQL-Bench release without modifying files."""

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


def validate_refs(track_root, tasks):
    for task in tasks:
        for field in ("schema_ref", "knowledge_ref"):
            relative = task.get(field)
            if relative:
                assert (track_root / relative).is_file(), f"Missing {field}: {relative}"


def validate_open_source():
    track_root = ROOT / "tracks/open_source_sql"
    tasks = read_jsonl(track_root / "tasks/tasks.jsonl")
    databases = read_jsonl(track_root / "metadata/databases.jsonl")
    summary = read_json(track_root / "metadata/benchmark_summary.json")
    assert len(tasks) == 1696 == summary["task_count"]
    assert len(databases) == 27 == summary["database_count"]
    assert len({task["task_id"] for task in tasks}) == len(tasks)
    assert all(task["execution_status"] == "ok" for task in tasks)
    assert sum(task["is_corrected"] for task in tasks) == 222
    validate_refs(track_root, tasks)
    return {
        "tasks": len(tasks),
        "databases": len(databases),
        "corrected_tasks": sum(task["is_corrected"] for task in tasks),
    }


def validate_shanghai():
    track_root = ROOT / "tracks/shanghai_mobility"
    tasks_path = track_root / "tasks/tasks.jsonl"
    tasks = read_jsonl(tasks_path)
    summary = read_json(track_root / "metadata/benchmark_summary.json")
    database = read_json(track_root / "metadata/database.json")
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
    assert sha256(tasks_path) == summary["tasks_sha256"]
    validate_refs(track_root, tasks)
    for task in tasks:
        result_path = track_root / task["result_ref"]
        sql_path = track_root / "sql" / f"{task['task_id']}.sql"
        assert result_path.is_file(), f"Missing result: {task['task_id']}"
        assert sql_path.is_file(), f"Missing SQL: {task['task_id']}"
        result = read_json(result_path)
        assert result["task_id"] == task["task_id"]
        assert result["execution_status"] == "ok"
        assert result["row_count"] > 0
    archive = track_root / database["archive_ref"]
    assert archive.stat().st_size == database["archive_size_bytes"]
    assert sha256(archive) == database["archive_sha256"]
    baseline = read_json(track_root / "baselines/three_models_20260910/summary.json")
    assert all(item["overall"]["total"] == 100 for item in baseline["models"].values())
    return {
        "tasks": len(tasks),
        "databases": 1,
        "categories": summary["categories"],
        "difficulty": summary["difficulty"],
    }


def main():
    benchmark = read_json(ROOT / "metadata/benchmark.json")
    tracks = read_json(ROOT / "metadata/tracks.json")
    assert benchmark["track_count"] == len(tracks) == 2
    open_source = validate_open_source()
    shanghai = validate_shanghai()
    assert benchmark["task_count"] == open_source["tasks"] + shanghai["tasks"]
    assert benchmark["database_count"] == open_source["databases"] + shanghai["databases"]
    print(
        json.dumps(
            {
                "status": "passed",
                "benchmark": benchmark["benchmark_name"],
                "version": benchmark["release_version"],
                "open_source_sql": open_source,
                "shanghai_mobility": shanghai,
            },
            ensure_ascii=False,
            indent=2,
        )
    )


if __name__ == "__main__":
    main()
