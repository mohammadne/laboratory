"""Database-backed task business logic.

This module intentionally knows nothing about HTTP. The router translates HTTP
input into method calls; this service owns SQL queries and transactions.
"""

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.task import TaskModel
from app.schemas.task import (
    Task,
    TaskCreate,
    TaskPriority,
    TaskReplace,
    TaskStatus,
)
from app.services.task_cache import TaskCache


class TaskService:
    """Store and manage tasks through one request-scoped AsyncSession."""

    def __init__(self, session: AsyncSession, cache: TaskCache) -> None:
        self.session = session
        self.cache = cache

    async def create(self, data: TaskCreate) -> TaskModel:
        """Insert and commit a task created from validated API input."""

        # mode="json" converts StrEnum values into plain strings suitable for
        # our String database columns. ``**`` unpacks the dictionary as keyword
        # arguments to TaskModel's generated constructor.
        task = TaskModel(**data.model_dump(mode="json"))
        self.session.add(task)
        await self._commit()
        # Refresh asks the database for generated values such as id/created_at.
        await self.session.refresh(task)
        await self.cache.set(task)
        return task

    async def list(
        self,
        *,
        status: TaskStatus | None,
        priority: TaskPriority | None,
        limit: int,
        offset: int,
    ) -> list[TaskModel]:
        """Build and execute a filtered SELECT query."""

        statement = select(TaskModel).order_by(TaskModel.id)
        if status is not None:
            statement = statement.where(TaskModel.status == status.value)
        if priority is not None:
            statement = statement.where(TaskModel.priority == priority.value)
        statement = statement.offset(offset).limit(limit)

        result = await self.session.scalars(statement)
        return list(result.all())

    async def get(self, task_id: int) -> TaskModel | Task | None:
        """Read through Redis, falling back to PostgreSQL on a cache miss."""

        cached_task = await self.cache.get(task_id)
        if cached_task is not None:
            return cached_task

        task = await self._get_from_database(task_id)
        if task is not None:
            await self.cache.set(task)
        return task

    async def replace(
        self, task_id: int, data: TaskReplace
    ) -> TaskModel | None:
        """Replace editable fields while preserving identity and creation time."""

        # Mutations must load the tracked ORM object from the source of truth;
        # a cached Pydantic response object cannot be updated by SQLAlchemy.
        task = await self._get_from_database(task_id)
        if task is None:
            return None

        for field, value in data.model_dump(mode="json").items():
            setattr(task, field, value)
        await self._commit()
        await self.session.refresh(task)
        await self.cache.set(task)
        return task

    async def update_status(
        self, task_id: int, status: TaskStatus
    ) -> TaskModel | None:
        """Change only a task's status."""

        task = await self._get_from_database(task_id)
        if task is None:
            return None

        task.status = status.value
        await self._commit()
        await self.session.refresh(task)
        await self.cache.set(task)
        return task

    async def delete(self, task_id: int) -> bool:
        """Delete a task and report whether it existed."""

        task = await self._get_from_database(task_id)
        if task is None:
            return False

        await self.session.delete(task)
        await self._commit()
        await self.cache.delete(task_id)
        return True

    async def _get_from_database(self, task_id: int) -> TaskModel | None:
        """Select the ORM entity by primary key, bypassing Redis."""

        return await self.session.get(TaskModel, task_id)

    async def _commit(self) -> None:
        """Commit the transaction, rolling it back if the database rejects it."""

        try:
            await self.session.commit()
        except Exception:
            # A failed transaction cannot be reused until it is rolled back.
            await self.session.rollback()
            raise
