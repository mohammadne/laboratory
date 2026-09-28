import time
import asyncio
import threading
from concurrent.futures import ThreadPoolExecutor, ProcessPoolExecutor

# Simulate I/O-bound work (e.g., network request)
def io_bound_task(task_id, duration=0.5):
    time.sleep(duration)
    return f"Task {task_id} completed"

# Simulate CPU-bound work
def cpu_bound_task(n):
    return sum(i * i for i in range(n))

async def async_io_bound_task(task_id, duration=0.5):
    await asyncio.sleep(duration)
    return f"Task {task_id} completed"

def main():
    print("=== Performance Comparison: Concurrency Approaches ===\n")

    # Test 1: Sequential I/O (baseline)
    print("Test 1: Sequential I/O (5 tasks x 0.5s)")
    start = time.time()
    for i in range(5):
        io_bound_task(i)
    print(f"  Time: {time.time() - start:.2f}s\n")

    # Test 2: Threading for I/O
    print("Test 2: Threading I/O (5 tasks x 0.5s)")
    start = time.time()
    with ThreadPoolExecutor(max_workers=5) as executor:
        list(executor.map(io_bound_task, range(5)))
    print(f"  Time: {time.time() - start:.2f}s\n")

    # Test 3: Asyncio for I/O
    print("Test 3: Asyncio I/O (5 tasks x 0.5s)")
    async def asyncio_test():
        start = time.time()
        await asyncio.gather(*[async_io_bound_task(i) for i in range(5)])
        return time.time() - start

    elapsed = asyncio.run(asyncio_test())
    print(f"  Time: {elapsed:.2f}s\n")

    # Test 4: CPU-bound sequential
    print("Test 4: Sequential CPU (4 tasks)")
    start = time.time()
    for _ in range(4):
        cpu_bound_task(10_000_000)
    print(f"  Time: {time.time() - start:.2f}s\n")

    # Test 5: CPU-bound with threading (affected by GIL)
    print("Test 5: Threading CPU (4 tasks) - Limited by GIL")
    start = time.time()
    with ThreadPoolExecutor(max_workers=4) as executor:
        list(executor.map(cpu_bound_task, [10_000_000] * 4))
    print(f"  Time: {time.time() - start:.2f}s\n")

    # Test 6: CPU-bound with multiprocessing
    print("Test 6: ProcessPoolExecutor CPU (4 tasks) - True parallelism")
    start = time.time()
    with ProcessPoolExecutor(max_workers=4) as executor:
        list(executor.map(cpu_bound_task, [10_000_000] * 4))
    print(f"  Time: {time.time() - start:.2f}s\n")

    print("=== Summary ===")
    print("I/O-bound (5 x 0.5s tasks):")
    print("  - Sequential:   ~2.5s")
    print("  - Threading:    ~0.5s  (5x faster)")
    print("  - Asyncio:      ~0.5s  (5x faster)")
    print()
    print("CPU-bound (4 tasks):")
    print("  - Sequential:   slowest")
    print("  - Threading:    similar to sequential (GIL contention)")
    print("  - Multiproc:    4x faster (true parallelism)")

if __name__ == "__main__":
    main()
