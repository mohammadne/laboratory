"""Redis cache-aside operations for individual tasks."""

import os

from pydantic import ValidationError
from redis.asyncio import Redis
from redis.exceptions import RedisError

from app.models.task import TaskModel
from app.schemas.task import Task


TASK_CACHE_TTL_SECONDS = int(os.getenv("TASK_CACHE_TTL_SECONDS", "60"))


class TaskCache:
    """Store serialized task responses in Redis for a limited time.

    PostgreSQL remains the source of truth. Redis is an optimization, so a
    connection failure becomes a cache miss instead of breaking the API.
    """

    def __init__(self, client: Redis) -> None:
        self.client = client

    @staticmethod
    def _key(task_id: int) -> str:
        # A namespace keeps our keys distinct from other applications using the
        # same Redis database.
        return f"task-manager:tasks:{task_id}"

    async def get(self, task_id: int) -> Task | None:
        """Return and validate a cached task, or report a cache miss."""

        try:
            payload = await self.client.get(self._key(task_id))
        except RedisError:
            return None

        if payload is None:
            return None

        try:
            return Task.model_validate_json(payload)
        except ValidationError:
            # Old or corrupt cache data must not leak through the API.
            await self.delete(task_id)
            return None

    async def set(self, task: TaskModel | Task) -> None:
        """Serialize a task as JSON and cache it with an expiration time."""

        task_schema = Task.model_validate(task)
        try:
            await self.client.set(
                self._key(task_schema.id),
                task_schema.model_dump_json(),
                ex=TASK_CACHE_TTL_SECONDS,
            )
        except RedisError:
            # Caching is optional; the committed PostgreSQL value is still safe.
            return

    async def delete(self, task_id: int) -> None:
        """Remove a possibly stale task after a database mutation."""

        try:
            await self.client.delete(self._key(task_id))
        except RedisError:
            return

