from __future__ import annotations

import argparse
import asyncio
import socket

from redis.asyncio import Redis

from .common import decode_event, ensure_group, redis_client
from .settings import GROUP, ORDERS_STREAM, PROCESSED_KEY_PREFIX


async def process(client: Redis, message_id: str, fields: dict[str, str]) -> None:
    event = decode_event(fields)
    order_id = str(event["order_id"])
    idempotency_key = f"{PROCESSED_KEY_PREFIX}{order_id}"

    # SET NX makes a redelivery harmless. A database unique index is a common
    # replacement when the side effect and idempotency record must be atomic.
    first_delivery = await client.set(idempotency_key, "1", nx=True, ex=86_400)
    if not first_delivery:
        print(f"duplicate {message_id}; acknowledging order={order_id}")
        await client.xack(ORDERS_STREAM, GROUP, message_id)
        return

    if event.get("simulate_failure"):
        # Do not XACK. The event remains in the pending-entry list for the reaper.
        await client.delete(idempotency_key)
        raise RuntimeError("simulated warehouse outage")

    print(f"fulfilled order={order_id} attempt={event['attempt']}")
    await client.xack(ORDERS_STREAM, GROUP, message_id)


async def run(consumer: str) -> None:
    client = await redis_client()
    await ensure_group(client)
    print(f"worker {consumer} listening on {ORDERS_STREAM} (Ctrl-C to stop)")
    try:
        while True:
            records = await client.xreadgroup(
                GROUP, consumer, {ORDERS_STREAM: ">"}, count=10, block=5000
            )
            for _, messages in records:
                for message_id, fields in messages:
                    try:
                        await process(client, message_id, fields)
                    except Exception as error:
                        print(f"failed {message_id}: {error}; left pending for recovery")
    finally:
        await client.aclose()


def main() -> None:
    parser = argparse.ArgumentParser(description="Run an order fulfilment consumer")
    parser.add_argument("--consumer", default=socket.gethostname())
    args = parser.parse_args()
    asyncio.run(run(args.consumer))


if __name__ == "__main__":
    main()
