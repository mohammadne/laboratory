"""Application entry point.

Run this module with ``uvicorn app.main:app --reload``.  Uvicorn imports the
``app`` object below and calls it for every HTTP request.
"""

from collections.abc import AsyncGenerator
from contextlib import asynccontextmanager

from fastapi import FastAPI

from app.cache import redis_client
from app.routers.tasks import router as tasks_router


@asynccontextmanager
async def lifespan(_: FastAPI) -> AsyncGenerator[None]:
    """Release application-wide async resources during server shutdown."""

    yield
    # Redis commands share a connection pool. The client lives for the whole
    # application and is closed once, rather than once per HTTP request.
    await redis_client.aclose()


# Creating FastAPI does not start a server. It builds an ASGI application that
# a server such as Uvicorn can run. Metadata also appears in the generated docs.
app = FastAPI(
    title="Task Manager API",
    description="A learning project for FastAPI's request/response flow.",
    version="0.1.0",
    lifespan=lifespan,
)


@app.get("/health", tags=["health"])
def health_check() -> dict[str, str]:
    """A tiny endpoint used to check that the process is responding."""

    # FastAPI serializes ordinary Python dictionaries to JSON automatically.
    return {"status": "ok"}


# Routers keep related endpoints out of this entry-point module. FastAPI adds
# every route declared by the router to this application at startup.
app.include_router(tasks_router)
