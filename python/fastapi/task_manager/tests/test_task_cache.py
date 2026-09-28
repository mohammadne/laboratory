"""Unit tests for Redis serialization without opening a network connection."""

import asyncio
from datetime import UTC, datetime

from app.schemas.task import Task, TaskPriority, TaskStatus
from app.services.task_cache import TASK_CACHE_TTL_SECONDS, TaskCache


class FakeRedisClient:
    """Implement only the Redis commands TaskCache needs."""

    def __init__(self) -> None:
        self.values: dict[str, str] = {}
        self.expirations: dict[str, int] = {}

    async def get(self, key: str) -> str | None:
        return self.values.get(key)

    async def set(self, key: str, value: str, *, ex: int) -> None:
        self.values[key] = value
        self.expirations[key] = ex

    async def delete(self, key: str) -> None:
        self.values.pop(key, None)
        self.expirations.pop(key, None)


def test_task_cache_serializes_and_expires_task() -> None:
    async def scenario() -> None:
        client = FakeRedisClient()
        cache = TaskCache(client)  # type: ignore[arg-type]
        task = Task(
            id=1,
            title="Learn Redis",
            description=None,
            status=TaskStatus.TODO,
            priority=TaskPriority.HIGH,
            created_at=datetime(2026, 8, 27, 10, tzinfo=UTC),
        )

        await cache.set(task)
        cached = await cache.get(task.id)

        assert cached == task
        assert client.expirations["task-manager:tasks:1"] == TASK_CACHE_TTL_SECONDS

    # The project does not need an async pytest plugin for one small unit test;
    # asyncio.run creates an event loop and waits for this scenario to finish.
    asyncio.run(scenario())
