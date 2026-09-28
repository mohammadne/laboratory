from __future__ import annotations

import argparse
import asyncio

from redis.asyncio import Redis

from .common import decode_event, encode_event, ensure_group, redis_client
from .settings import DEAD_LETTER_STREAM, GROUP, ORDERS_STREAM


async def recover(client: Redis, min_idle_ms: int, max_attempts: int) -> int:
    """Claim abandoned pending events and either retry or dead-letter them."""
    start_id = "0-0"
    recovered = 0
    while True:
        start_id, messages, _ = await client.xautoclaim(
            ORDERS_STREAM, GROUP, "reaper", min_idle_ms, start_id, count=100
        )
        for message_id, fields in messages:
            event = decode_event(fields)
            next_attempt = int(event["attempt"]) + 1
            event["attempt"] = next_attempt
            event["recovered_from"] = message_id
            if next_attempt >= max_attempts:
                await client.xadd(DEAD_LETTER_STREAM, encode_event(event))
                print(f"dead-lettered {message_id} after {next_attempt} attempts")
            else:
                await client.xadd(ORDERS_STREAM, encode_event(event))
                print(f"republished {message_id} as retry attempt={next_attempt}")
            await client.xack(ORDERS_STREAM, GROUP, message_id)
            recovered += 1
        if start_id == "0-0":
            return recovered


def main() -> None:
    parser = argparse.ArgumentParser(description="Recover abandoned stream messages")
    parser.add_argument("--min-idle-ms", type=int, default=60_000)
    parser.add_argument("--max-attempts", type=int, default=3)
    args = parser.parse_args()

    async def run() -> None:
        client = await redis_client()
        try:
            await ensure_group(client)
            print(f"recovered {await recover(client, args.min_idle_ms, args.max_attempts)} event(s)")
        finally:
            await client.aclose()

    asyncio.run(run())


if __name__ == "__main__":
    main()
