"""HTTP endpoints for task operations."""

from typing import Annotated

from fastapi import APIRouter, Depends, HTTPException, Query, Response, status

from app.dependencies import get_task_service
from app.models.task import TaskModel
from app.schemas.task import (
    Task,
    TaskCreate,
    TaskPriority,
    TaskReplace,
    TaskStatus,
    TaskStatusUpdate,
)
from app.services.task import TaskService

# The prefix is applied to every path below; tags group them in Swagger UI.
router = APIRouter(prefix="/tasks", tags=["tasks"])

# Annotated keeps the real Python type (TaskService) next to FastAPI's Depends
# instruction. Before calling a route, FastAPI calls get_task_service and passes
# its return value into the ``service`` argument.
TaskServiceDependency = Annotated[TaskService, Depends(get_task_service)]


async def require_task(service: TaskService, task_id: int) -> TaskModel | Task:
    """Turn the service's missing-value result into an HTTP 404 response."""

    task = await service.get(task_id)
    if task is None:
        raise HTTPException(status_code=404, detail="Task not found")
    return task


@router.post("", response_model=Task, status_code=status.HTTP_201_CREATED)
async def create_task(body: TaskCreate, service: TaskServiceDependency) -> TaskModel:
    """Create a task.

    FastAPI reads JSON into ``body``, asks Pydantic to validate it, resolves the
    service dependency, and only then invokes this function.
    """

    return await service.create(body)


@router.get("", response_model=list[Task])
async def list_tasks(
    service: TaskServiceDependency,
    task_status: Annotated[TaskStatus | None, Query(alias="status")] = None,
    priority: TaskPriority | None = None,
    limit: Annotated[int, Query(ge=1, le=100)] = 20,
    offset: Annotated[int, Query(ge=0)] = 0,
) -> list[TaskModel]:
    """List tasks with optional enum filters and validated pagination."""

    return await service.list(
        status=task_status,
        priority=priority,
        limit=limit,
        offset=offset,
    )


@router.get("/{task_id}", response_model=Task)
async def get_task(
    task_id: int,
    service: TaskServiceDependency,
) -> TaskModel | Task:
    """Get one task; path parameters are parsed and validated as integers."""

    return await require_task(service, task_id)


@router.put("/{task_id}", response_model=Task)
async def replace_task(
    task_id: int,
    body: TaskReplace,
    service: TaskServiceDependency,
) -> TaskModel:
    """Replace a task's client-editable fields."""

    task = await service.replace(task_id, body)
    if task is None:
        raise HTTPException(status_code=404, detail="Task not found")
    return task


@router.patch("/{task_id}/status", response_model=Task)
async def update_task_status(
    task_id: int,
    body: TaskStatusUpdate,
    service: TaskServiceDependency,
) -> TaskModel:
    """Update only the status, demonstrating a focused PATCH operation."""

    task = await service.update_status(task_id, body.status)
    if task is None:
        raise HTTPException(status_code=404, detail="Task not found")
    return task


@router.delete("/{task_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_task(task_id: int, service: TaskServiceDependency) -> Response:
    """Delete a task; a 204 response deliberately has no JSON body."""

    if not await service.delete(task_id):
        raise HTTPException(status_code=404, detail="Task not found")
    return Response(status_code=status.HTTP_204_NO_CONTENT)
