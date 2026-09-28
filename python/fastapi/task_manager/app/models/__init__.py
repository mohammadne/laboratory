"""SQLAlchemy persistence models."""

# Import models here so ``Base.metadata`` sees them when Alembic or tests import
# this package. Defining a Python class is what registers its table metadata.
from app.models.task import TaskModel

__all__ = ["TaskModel"]

