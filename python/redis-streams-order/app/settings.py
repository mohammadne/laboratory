import os

REDIS_URL = os.getenv("REDIS_URL", "redis://localhost:6379/0")
ORDERS_STREAM = "orders:events"
DEAD_LETTER_STREAM = "orders:dead-letter"
GROUP = "fulfilment"
PROCESSED_KEY_PREFIX = "processed:order:"
