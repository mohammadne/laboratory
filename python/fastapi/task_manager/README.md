# Task Manager

A small but complete REST API for learning FastAPI. Tasks are persisted in
PostgreSQL through SQLAlchemy's async API, and database schema changes are
managed with Alembic. Redis provides a short-lived cache for individual task
reads while PostgreSQL remains the source of truth.

The project demonstrates:

- route decorators, path parameters, and query parameters;
- Pydantic request validation and response models;
- `APIRouter` and dependency injection with `Depends`;
- separation between the HTTP router and business logic;
- SQLAlchemy 2.x models, async sessions, queries, and transactions;
- PostgreSQL persistence and Alembic migrations;
- async Redis cache-aside reads, TTLs, and cache invalidation;
- status codes and errors (`201`, `204`, `404`, and `422`);
- basic API testing with pytest and FastAPI's `TestClient`;
- automatically generated OpenAPI/Swagger documentation.

## Requirements

- Python 3.11 or newer
- [uv](https://docs.astral.sh/uv/getting-started/installation/)
- PostgreSQL and Redis, or Docker with the Compose plugin

## Run locally

From this directory, install the project and its development dependencies:

```bash
uv sync
```

uv creates and manages the local `.venv` automatically. You do not need to
activate it; `uv run` executes commands inside the project environment.

Start the provided PostgreSQL and Redis development services:

```bash
docker compose up -d
```

The default database URL used by the application is:

```text
postgresql+asyncpg://task_manager:task_manager@localhost:5432/task_manager
```

To use another PostgreSQL server, set `DATABASE_URL`. See `.env.example` for the
format.

Redis defaults to `redis://localhost:6379/0`, and individual task values expire
after 60 seconds. Override these with `REDIS_URL` and
`TASK_CACHE_TTL_SECONDS`. If Redis is unavailable, individual reads fall back to
PostgreSQL instead of failing the API request.

Apply all pending database migrations:

```bash
uv run alembic upgrade head
```

Start the development server:

```bash
uv run uvicorn app.main:app --reload
```

Then open:

- API documentation: <http://127.0.0.1:8000/docs>
- Alternative documentation: <http://127.0.0.1:8000/redoc>
- Health check: <http://127.0.0.1:8000/health>

`--reload` watches source files and restarts the development process after a
change. Do not use it as a production server setting.

The database container can be stopped later with `docker compose down`. Its
named volume preserves task data between container restarts.

## Try the API

Create a task:

```bash
curl -i -X POST http://127.0.0.1:8000/tasks \
  -H 'Content-Type: application/json' \
  -d '{"title":"Learn FastAPI","description":"Build the task API","priority":"high"}'
```

List and filter tasks:

```bash
curl 'http://127.0.0.1:8000/tasks?status=todo&priority=high&limit=20&offset=0'
```

Update only a task's status:

```bash
curl -X PATCH http://127.0.0.1:8000/tasks/1/status \
  -H 'Content-Type: application/json' \
  -d '{"status":"done"}'
```

## Run the tests

After running `uv sync`:

```bash
uv run pytest
```

The tests use `TestClient`, which calls the FastAPI ASGI application directly.
Each test gets a new temporary SQLite database and an observable in-memory cache
double, so PostgreSQL, Redis, Docker, ports, and real network requests are not
needed. The application still uses the same routes, service, SQLAlchemy model,
async session code, and cache behavior. Start with
`tests/test_health.py`, then read `tests/test_tasks.py` for examples of:

- arranging data, making a request, and asserting a response;
- using a pytest fixture to isolate tests;
- testing successful CRUD operations;
- testing validation (`422`) and missing resources (`404`);
- testing filters and pagination.
- overriding external dependencies and verifying cache invalidation.

SQLite keeps these introductory tests fast and isolated. A production project
should additionally run integration tests against PostgreSQL because the two
database engines do not behave identically.

## Request flow

For `POST /tasks`, the important flow is:

```text
HTTP JSON request
      ↓
FastAPI matches the route
      ↓
Pydantic parses and validates TaskCreate
      ↓
FastAPI resolves get_task_service()
      ↓
get_task_service receives an AsyncSession
      ↓
async route awaits the service
      ↓
service builds a SQLAlchemy TaskModel
      ↓
AsyncSession INSERTs and commits the transaction
      ↓
PostgreSQL generates id and created_at
      ↓
service stores the response in Redis with a TTL
      ↓
Pydantic converts TaskModel to the Task response schema
      ↓
HTTP 201 response
```

If input is invalid, FastAPI returns `422` before the route handler runs. If a
task ID is valid but does not exist, our route raises `HTTPException(404)`.

For `GET /tasks/{id}`, the cache-aside flow is:

```text
request
   ↓
look up task-manager:tasks:{id} in Redis
   ├── cache hit  → validate cached JSON → response
   └── cache miss or Redis unavailable
             ↓
          query PostgreSQL
             ↓
          cache result for 60 seconds
             ↓
          response
```

Create and update operations refresh the cached value after the database commit.
Delete removes the cache key after the database row is deleted. List responses
are deliberately not cached, keeping invalidation simple for this learning
project.

## Database concepts in this project

### SQLAlchemy model versus Pydantic schema

`app/models/task.py` defines `TaskModel`, which describes the `tasks` database
table: columns, SQL types, primary key, and constraints.

`app/schemas/task.py` defines Pydantic models such as `TaskCreate` and `Task`,
which describe the public JSON input and output. Keeping them separate prevents
database implementation details from becoming part of the API contract.

### Engine, session, and transaction

- The SQLAlchemy `engine` owns a pool of database connections.
- `get_db_session()` opens one `AsyncSession` per HTTP request and closes it
  afterward.
- `get_task_service()` receives that session through dependency injection and
  creates a request-scoped service.
- The service uses `select(...)` for reads and `commit()` for writes. If a commit
  fails, `_commit()` rolls the transaction back before re-raising the error.
- `await` releases the event loop while the database driver is waiting for
  PostgreSQL.

### Redis client and task cache

`app/cache.py` creates one application-wide async Redis client. Like the
SQLAlchemy engine, this object is safe to share because it owns a connection
pool. It is closed once during FastAPI's lifespan shutdown—not once per request.

`TaskCache` owns key naming, Pydantic JSON serialization, TTLs, and Redis error
handling. PostgreSQL remains authoritative: Redis failures are treated as cache
misses, and mutations always update PostgreSQL before touching the cache.

### Migrations

Changing a SQLAlchemy model does not automatically change existing database
tables. Alembic migrations record schema changes as versioned Python files.

After changing a model, generate a candidate migration:

```bash
uv run alembic revision --autogenerate -m "describe the schema change"
```

Always review the generated file. Then apply it:

```bash
uv run alembic upgrade head
```

Useful inspection commands are:

```bash
uv run alembic current
uv run alembic history
```

## Project structure

```text
pyproject.toml          # Project metadata and runtime/development dependencies
uv.lock                 # Exact dependency versions resolved by uv
alembic.ini             # Alembic configuration
compose.yaml            # Local PostgreSQL and Redis development services
migrations/
└── versions/           # Ordered database schema changes
app/
├── main.py             # Create the FastAPI app and attach routers
├── cache.py             # Shared async Redis client and connection pool
├── database.py         # Async engine, session factory, and session dependency
├── dependencies.py     # Inject the session, cache, and TaskService
├── models/
│   └── task.py         # SQLAlchemy tasks table mapping
├── routers/
│   └── tasks.py        # HTTP paths, status codes, and error translation
├── schemas/
│   └── task.py         # Pydantic input/output models and validation
└── services/
    ├── task.py         # SQL queries, transactions, and cache-aside flow
    └── task_cache.py   # Redis serialization, TTL, and invalidation operations
tests/
├── conftest.py         # Shared TestClient fixture
├── test_health.py      # Minimal first test
└── test_tasks.py       # CRUD, filter, error, and validation tests
```

Reading order: `app/main.py` → `app/routers/tasks.py` → `app/dependencies.py` →
`app/database.py` and `app/cache.py` → `app/schemas/task.py` and
`app/models/task.py` → `app/services/task_cache.py` and `app/services/task.py` →
`migrations/` → `tests/`.

## API

A task looks roughly like:

```json
{
  "id": 123,
  "title": "Learn FastAPI",
  "description": "Build the task API",
  "status": "todo",
  "priority": "high",
  "created_at": "2026-08-27T10:00:00Z"
}
```

```text
GET    /health

POST   /tasks
GET    /tasks
GET    /tasks/{id}
PUT    /tasks/{id}
DELETE /tasks/{id}

PATCH  /tasks/{id}/status
```

Listing supports:

```http
GET /tasks?status=todo
GET /tasks?priority=high
GET /tasks?limit=20&offset=0
```

Allowed status values are `todo`, `in_progress`, and `done`. Allowed priority
values are `low`, `medium`, and `high`. Open `/docs` for the complete interactive
schema and example requests.

## Suggested next stages

**Stage 1 — FastAPI basics (implemented, then evolved):** The project started
with in-memory storage and still demonstrates routes, path/query parameters,
Pydantic models, validation, errors, status codes, and Swagger.

**Stage 2 — Structure (implemented):** `APIRouter`, dependency injection with
`Depends()`, and separation between HTTP and business logic.

**Stage 3 — Database (implemented):** PostgreSQL replaces the dictionary and
uses **SQLAlchemy 2.x**:

```text
FastAPI
   ↓
Service
   ↓
SQLAlchemy
   ↓
PostgreSQL
```

This stage demonstrates sessions, models versus Pydantic schemas, transactions,
migrations with Alembic, and async database access.

**Redis cache (implemented):** `GET /tasks/{id}` uses cache-aside reads with a
60-second TTL. Database mutations refresh or invalidate the key, and dependency
overrides provide a fake cache during tests.

**Stage 4 — Concurrency:** Add an endpoint such as:

```http
POST /tasks/{id}/analyze
```

Have it call an external HTTP service asynchronously. This forces you to practice what we've just discussed:

```python
async def
await
async with
httpx.AsyncClient
asyncio
timeouts
```

For example:

```text
request
   ↓
FastAPI async handler
   ↓
HTTP call ──────── waiting
   ↓                 │
response          event loop
                     │
                 handles other
                  requests
```

**Stage 5 — Production basics (partly implemented):** Pytest tests, error
handling, and `/health` are included. Compose currently runs only the development
database; authentication, logging, structured configuration, and containerizing
the application remain useful follow-up exercises.

## Deliberately not included

Skip Kafka, Celery, Kubernetes, elaborate repository patterns, and microservices.
They will distract you from learning FastAPI itself. Redis is included only as a
small cache-aside example.

The intended learning path is **FastAPI → Pydantic → dependency injection →
testing → async/await → SQLAlchemy**.
