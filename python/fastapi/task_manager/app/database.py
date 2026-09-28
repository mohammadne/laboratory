"""Database engine, session factory, and FastAPI session dependency."""

import os
from collections.abc import AsyncGenerator

from sqlalchemy.ext.asyncio import (
    AsyncSession,
    async_sessionmaker,
    create_async_engine,
)
from sqlalchemy.orm import DeclarativeBase


# SQLAlchemy URLs name both a database and a driver. ``postgresql+asyncpg``
# selects PostgreSQL plus the asyncpg driver required for non-blocking I/O.
DATABASE_URL = os.getenv(
    "DATABASE_URL",
    "postgresql+asyncpg://task_manager:task_manager@localhost:5432/task_manager",
)

# An Engine owns the database connection pool. Creating it does not immediately
# connect; a connection is checked out when a request first executes SQL.
engine = create_async_engine(DATABASE_URL, pool_pre_ping=True)

# A session factory creates short-lived AsyncSession objects. A session tracks
# ORM objects and represents one unit of work with the database.
AsyncSessionFactory = async_sessionmaker(engine, expire_on_commit=False)


class Base(DeclarativeBase):
    """Base class whose metadata contains every SQLAlchemy table model."""


async def get_db_session() -> AsyncGenerator[AsyncSession]:
    """Give one database session to a request, then always close it.

    Code before ``yield`` is dependency setup. Code after it is cleanup. The
    service explicitly commits write transactions; closing an uncommitted
    session causes SQLAlchemy to roll that transaction back.
    """

    async with AsyncSessionFactory() as session:
        yield session
