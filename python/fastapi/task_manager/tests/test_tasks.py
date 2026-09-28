"""Examples of testing CRUD, filtering, errors, and validation."""

from fastapi.testclient import TestClient

from tests.conftest import FakeTaskCache


def create_task(client: TestClient, **overrides: object) -> dict[str, object]:
    """Small test helper that creates a task and returns its JSON body."""

    payload: dict[str, object] = {
        "title": "Learn FastAPI",
        "description": "Build the task API",
        "priority": "high",
    }
    payload.update(overrides)
    response = client.post("/tasks", json=payload)
    assert response.status_code == 201
    return response.json()


def test_create_then_get_task(client: TestClient) -> None:
    created = create_task(client)

    assert created["id"] == 1
    assert created["status"] == "todo"
    assert created["created_at"]  # Server-generated field is present.

    response = client.get("/tasks/1")

    assert response.status_code == 200
    assert response.json() == created


def test_list_supports_filters_and_pagination(client: TestClient) -> None:
    create_task(client, title="First", priority="low")
    create_task(client, title="Second", priority="high", status="done")
    create_task(client, title="Third", priority="high")

    filtered = client.get("/tasks", params={"priority": "high"})
    paged = client.get("/tasks", params={"limit": 1, "offset": 1})

    assert filtered.status_code == 200
    assert [task["title"] for task in filtered.json()] == ["Second", "Third"]
    assert [task["title"] for task in paged.json()] == ["Second"]


def test_replace_patch_and_delete_task(client: TestClient) -> None:
    create_task(client)

    replaced = client.put(
        "/tasks/1",
        json={"title": "Understand FastAPI", "priority": "medium"},
    )
    assert replaced.status_code == 200
    assert replaced.json()["title"] == "Understand FastAPI"

    patched = client.patch("/tasks/1/status", json={"status": "done"})
    assert patched.status_code == 200
    assert patched.json()["status"] == "done"

    deleted = client.delete("/tasks/1")
    assert deleted.status_code == 204
    assert deleted.content == b""
    assert client.get("/tasks/1").status_code == 404


def test_invalid_input_returns_422_before_endpoint_runs(client: TestClient) -> None:
    blank_title = client.post("/tasks", json={"title": "   "})
    bad_priority = client.post(
        "/tasks", json={"title": "A task", "priority": "urgent"}
    )
    bad_id = client.get("/tasks/not-an-integer")
    bad_limit = client.get("/tasks", params={"limit": 0})

    assert blank_title.status_code == 422
    assert bad_priority.status_code == 422
    assert bad_id.status_code == 422
    assert bad_limit.status_code == 422


def test_unknown_task_returns_404(client: TestClient) -> None:
    response = client.get("/tasks/999")

    assert response.status_code == 404
    assert response.json() == {"detail": "Task not found"}


def test_get_uses_cache_and_mutations_keep_it_fresh(
    client: TestClient,
    task_cache: FakeTaskCache,
) -> None:
    created = create_task(client)
    assert task_cache.values[1].title == created["title"]

    fetched = client.get("/tasks/1")
    assert fetched.status_code == 200
    assert task_cache.get_calls == [1]

    updated = client.patch("/tasks/1/status", json={"status": "done"})
    assert updated.status_code == 200
    assert task_cache.values[1].status == "done"

    deleted = client.delete("/tasks/1")
    assert deleted.status_code == 204
    assert 1 not in task_cache.values
