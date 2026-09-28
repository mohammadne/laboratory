from __future__ import annotations

import asyncio

from .common import ensure_group, redis_client
from .settings import DEAD_LETTER_STREAM, GROUP, ORDERS_STREAM


async def main_async() -> None:
    client = await redis_client()
    try:
        await ensure_group(client)
        stream_size = await client.xlen(ORDERS_STREAM)
        dlq_size = await client.xlen(DEAD_LETTER_STREAM)
        groups = await client.xinfo_groups(ORDERS_STREAM)
        group = next(item for item in groups if item["name"] == GROUP)
        print(f"stream={ORDERS_STREAM} entries={stream_size}")
        print(f"group={GROUP} pending={group['pending']} consumers={group['consumers']}")
        print(f"dead_letter={DEAD_LETTER_STREAM} entries={dlq_size}")
        if group["pending"]:
            for item in await client.xpending_range(ORDERS_STREAM, GROUP, "-", "+", 10):
                print(
                    f"pending id={item['message_id']} consumer={item['consumer']} "
                    f"deliveries={item['times_delivered']} idle_ms={item['time_since_delivered']}"
                )
    finally:
        await client.aclose()


if __name__ == "__main__":
    asyncio.run(main_async())
