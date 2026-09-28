"""Request and response shapes for tasks."""

from datetime import datetime
from enum import StrEnum

from pydantic import BaseModel, ConfigDict, Field, field_validator


class TaskStatus(StrEnum):
    """Allowed task states.

    Using an enum makes invalid values fail validation before business logic
    runs, and makes the choices visible in Swagger's generated documentation.
    """

    TODO = "todo"
    IN_PROGRESS = "in_progress"
    DONE = "done"


class TaskPriority(StrEnum):
    """Allowed priority values."""

    LOW = "low"
    MEDIUM = "medium"
    HIGH = "high"


class TaskFields(BaseModel):
    """Fields supplied when a complete task representation is accepted."""

    title: str = Field(min_length=1, max_length=200)
    description: str | None = Field(default=None, max_length=2_000)
    status: TaskStatus = TaskStatus.TODO
    priority: TaskPriority = TaskPriority.MEDIUM

    # Pydantic validators transform or reject input before the endpoint runs.
    @field_validator("title")
    @classmethod
    def title_must_not_be_blank(cls, value: str) -> str:
        stripped = value.strip()
        if not stripped:
            raise ValueError("title must not be blank")
        return stripped


class TaskCreate(TaskFields):
    """JSON body accepted by ``POST /tasks``."""


class TaskReplace(TaskFields):
    """JSON body accepted by ``PUT /tasks/{id}``.

    PUT represents a full replacement. Defaults keep the example approachable:
    omitted status and priority return to their documented default values.
    """


class TaskStatusUpdate(BaseModel):
    """Small JSON body accepted by the status-only PATCH endpoint."""

    status: TaskStatus


class Task(TaskFields):
    """Public task shape returned to API clients."""

    # ``from_attributes`` lets Pydantic read attributes from a SQLAlchemy object
    # instead of requiring a dictionary. FastAPI uses this when serializing the
    # TaskModel returned by a route into this public Task response schema.
    model_config = ConfigDict(from_attributes=True, frozen=True)

    id: int
    created_at: datetime
