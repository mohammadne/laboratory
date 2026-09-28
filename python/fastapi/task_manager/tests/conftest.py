"""Shared pytest setup."""

import asyncio
from collections.abc import Iterator

import pytest
from fastapi.testclient import TestClient
from sqlalchemy.ext.asyncio import async_sessionmaker, create_async_engine

import app.models  # noqa: F401  # Register tables on Base.metadata.
from app.database import Base, get_db_session
from app.dependencies import get_task_cache
from app.main import app
from app.models.task import TaskModel
from app.schemas.task import Task


class FakeTaskCache:
    """Small in-memory replacement for Redis used only by tests."""

    def __init__(self) -> None:
        self.values: dict[int, Task] = {}
        self.get_calls: list[int] = []

    async def get(self, task_id: int) -> Task | None:
        self.get_calls.append(task_id)
        return self.values.get(task_id)

    async def set(self, task: TaskModel | Task) -> None:
        task_schema = Task.model_validate(task)
        self.values[task_schema.id] = task_schema

    async def delete(self, task_id: int) -> None:
        self.values.pop(task_id, None)


@pytest.fixture
def task_cache() -> FakeTaskCache:
    """Return an observable cache double without requiring a Redis server."""

    return FakeTaskCache()


@pytest.fixture
def client(tmp_path, task_cache: FakeTaskCache) -> Iterator[TestClient]:
    """Give each test an HTTP client connected to a fresh SQLite database.

    ``yield`` splits fixture setup from cleanup. TestClient sends requests
    directly to the ASGI application, so tests need no real network or server.
    The application uses PostgreSQL normally; dependency overriding lets tests
    substitute SQLite while exercising the same routes and service code.
    """

    database_path = tmp_path / "tasks.db"
    test_engine = create_async_engine(f"sqlite+aiosqlite:///{database_path}")
    test_session_factory = async_sessionmaker(
        test_engine,
        expire_on_commit=False,
    )

    async def create_tables() -> None:
        async with test_engine.begin() as connection:
            await connection.run_sync(Base.metadata.create_all)

    async def override_get_db_session():
        async with test_session_factory() as session:
            yield session

    asyncio.run(create_tables())
    app.dependency_overrides[get_db_session] = override_get_db_session
    app.dependency_overrides[get_task_cache] = lambda: task_cache

    try:
        with TestClient(app) as test_client:
            yield test_client
    finally:
        app.dependency_overrides.clear()
        asyncio.run(test_engine.dispose())
