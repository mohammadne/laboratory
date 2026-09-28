import time
import threading
from queue import Queue

print("=== Threading Queue ===")

q_threading = Queue()

def producer(queue: Queue):
    for i in range(5):
        item = f"job-{i}"
        queue.put(item)
        print(f"Produced: {item}")
        time.sleep(0.1)

def consumer(queue: Queue):
    for _ in range(5):
        job = queue.get()  # blocks thread until item available
        print(f"Consumed: {job}")
        time.sleep(0.2)

t1 = threading.Thread(target=producer, args=(q_threading,))
t2 = threading.Thread(target=consumer, args=(q_threading,))

t1.start()
t2.start()

t1.join()
t2.join()

print()

# Asyncio Queue Example
import asyncio

print("=== Asyncio Queue ===")

q_asyncio = asyncio.Queue()

async def producer_async(queue: asyncio.Queue):
    for i in range(5):
        item = f"job-{i}"
        await queue.put(item)
        print(f"Produced: {item}")
        await asyncio.sleep(0.1)

async def consumer_async(queue: asyncio.Queue):
    for _ in range(5):
        job = await queue.get()
        print(f"Consumed: {job}")
        await asyncio.sleep(0.2)

async def main():
    await asyncio.gather(
        producer_async(q_asyncio),
        consumer_async(q_asyncio),
    )

asyncio.run(main())
