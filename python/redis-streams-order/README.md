# Redis Streams: order pipeline

A compact Python project for learning the Redis Streams patterns used in production
services. It models an order service that publishes `order.created` events and a
fulfilment worker that processes them through a consumer group.

It deliberately includes the operational pieces usually missing from hello-world
examples:

- consumer groups (`XREADGROUP`) for load sharing
- acknowledgements only after work succeeds (`XACK`)
- idempotency, so redelivery is safe
- a recovery worker that takes abandoned pending messages (`XAUTOCLAIM`)
- bounded retries and a dead-letter stream
- a monitor for stream length, pending messages, and consumers

## Run it

Requirements: Docker and Python 3.12+.

```bash
docker compose up -d
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

# Terminal 1: process new orders
python -m app.worker

# Terminal 2: publish two normal orders and one intentional failure
python -m app.producer --count 2
python -m app.producer --count 1 --fail

# Terminal 3: inspect state, then recover the failed pending event
python -m app.monitor
python -m app.reaper --min-idle-ms 1000 --max-attempts 3
python -m app.monitor
```

Run the reaper three times (waiting at least `--min-idle-ms` between runs) to move
the intentional failure to `orders:dead-letter`. The worker never acknowledges a
failed event; recovery republishes it with an incremented `attempt` and acknowledges
the abandoned original. That makes the retry history explicit and avoids an
ever-growing pending-entry list.

To start from scratch:

```bash
docker compose down -v
```

## Architecture

```text
producer ──XADD──> orders:events ──XREADGROUP──> fulfilment workers
                         │                 │ success: XACK + idempotency record
                         │                 └ failure: stays pending
                         ▼
                  recovery reaper ──XAUTOCLAIM──> retry event or orders:dead-letter
```

Redis Streams provides **at-least-once**, not exactly-once, delivery. The
`SET processed:{order_id}` record is the application's idempotency guard; in a real
service this would often be a database uniqueness constraint or transactional outbox.

## Useful commands

```bash
# Run two consumers to see group load sharing
python -m app.worker --consumer worker-a
python -m app.worker --consumer worker-b

# Read the dead-letter stream directly
redis-cli XRANGE orders:dead-letter - +

# Inspect a group's pending entries
redis-cli XPENDING orders:events fulfilment - + 10
```
