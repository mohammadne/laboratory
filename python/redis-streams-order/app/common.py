from __future__ import annotations

import json
from collections.abc import Mapping

from redis.asyncio import Redis
from redis.exceptions import ResponseError

from .settings import GROUP, ORDERS_STREAM


async def redis_client() -> Redis:
    from .settings import REDIS_URL

    client = Redis.from_url(REDIS_URL, decode_responses=True)
    await client.ping()
    return client


async def ensure_group(client: Redis) -> None:
    """Create the stream and group once; safe when many workers start together."""
    try:
        await client.xgroup_create(ORDERS_STREAM, GROUP, id="0", mkstream=True)
    except ResponseError as error:
        if "BUSYGROUP" not in str(error):
            raise


def encode_event(event: Mapping[str, object]) -> dict[str, str]:
    return {key: json.dumps(value) for key, value in event.items()}


def decode_event(fields: Mapping[str, str]) -> dict[str, object]:
    return {key: json.loads(value) for key, value in fields.items()}
