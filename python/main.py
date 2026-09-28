from typing import Any, Callable, TypeVar, overload
import os


def str_to_bool(value: str | bool) -> bool: # type: ignore
    if isinstance(value, bool):
        return value
    return value.lower() in ("1", "true", "yes", "on")


def get_env(
    env_key: str,
    cast: Callable[[str], Any] = str,
    default: Any = None,
) -> Any:
    value = os.getenv(env_key)
    if value is None or value == "":
        return default

    if cast is bool:
        return str_to_bool(value)
    elif cast is int:
        return int(value)
    elif cast is float:
        return float(value)
    return value
