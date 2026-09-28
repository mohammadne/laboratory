from __future__ import annotations

import argparse
import asyncio
import uuid

from .common import encode_event, redis_client
from .settings import ORDERS_STREAM


async def publish(count: int, fail: bool) -> None:
    client = await redis_client()
    try:
        for _ in range(count):
            order_id = str(uuid.uuid4())
            event = {
                "event_type": "order.created",
                "order_id": order_id,
                "customer_id": f"customer-{order_id[:8]}",
                "amount_cents": 2499,
                "attempt": 0,
                "simulate_failure": fail,
            }
            message_id = await client.xadd(ORDERS_STREAM, encode_event(event))
            print(f"published {message_id}: order={order_id} fail={fail}")
    finally:
        await client.aclose()


def main() -> None:
    parser = argparse.ArgumentParser(description="Publish order.created events")
    parser.add_argument("--count", type=int, default=1)
    parser.add_argument("--fail", action="store_true", help="leave events pending")
    args = parser.parse_args()
    asyncio.run(publish(args.count, args.fail))


if __name__ == "__main__":
    main()
