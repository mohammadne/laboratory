"""FastAPI dependencies shared by route handlers."""

from typing import Annotated

from fastapi import Depends
from redis.asyncio import Redis
from sqlalchemy.ext.asyncio import AsyncSession

from app.cache import get_redis_client
from app.database import get_db_session
from app.services.task import TaskService
from app.services.task_cache import TaskCache


DatabaseSessionDependency = Annotated[AsyncSession, Depends(get_db_session)]
RedisClient = Annotated[Redis, Depends(get_redis_client)]


def get_task_cache(client: RedisClient) -> TaskCache:
    """Build the task cache around the shared Redis client."""

    return TaskCache(client)


TaskCacheDependency = Annotated[TaskCache, Depends(get_task_cache)]


def get_task_service(
    session: DatabaseSessionDependency,
    cache: TaskCacheDependency,
) -> TaskService:
    """Build a task service around this request's database session.

    This is a dependency chain: FastAPI first resolves ``get_db_session``, then
    resolves the shared Redis client and cache, then passes both dependencies
    here. A new service and database session are used for every request.
    """

    return TaskService(session, cache)
