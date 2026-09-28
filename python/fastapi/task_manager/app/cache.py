"""Shared Redis client and its FastAPI dependency."""

import os

from redis.asyncio import Redis


REDIS_URL = os.getenv("REDIS_URL", "redis://localhost:6379/0")

# Redis clients are safe to share: the client owns a connection pool and checks
# out connections for individual commands. This mirrors the shared SQLAlchemy
# Engine, not the request-scoped AsyncSession.
redis_client: Redis = Redis.from_url(
    REDIS_URL,
    socket_connect_timeout=0.5,
    socket_timeout=0.5,
)


def get_redis_client() -> Redis:
    """Return the application-wide async Redis client."""

    return redis_client

