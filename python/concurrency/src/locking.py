import asyncio
import threading

# Asyncio Lock Example
print("=== Asyncio Lock ===")

counter = 0
lock = asyncio.Lock()

async def worker_asyncio(name, count):
    global counter
    for _ in range(count):
        async with lock:
            counter += 1
            print(f"{name}: counter = {counter}")
        await asyncio.sleep(0.01)

async def main_asyncio():
    global counter
    counter = 0
    await asyncio.gather(
        worker_asyncio("A", 3),
        worker_asyncio("B", 3),
    )
    print(f"Final counter: {counter}\n")

asyncio.run(main_asyncio())

# Threading Lock Example
print("=== Threading Lock ===")

counter = 0
lock = threading.Lock()

def worker_thread(name, count):
    global counter
    for _ in range(count):
        with lock:
            counter += 1
            print(f"{name}: counter = {counter}")

threads = [
    threading.Thread(target=worker_thread, args=("A", 3)),
    threading.Thread(target=worker_thread, args=("B", 3)),
]

for t in threads:
    t.start()

for t in threads:
    t.join()

print(f"Final counter: {counter}\n")
