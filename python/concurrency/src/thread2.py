import time
from concurrent.futures import ThreadPoolExecutor

print("=== ThreadPoolExecutor: Simulate I/O operations ===\n")

tasks = [
    ("Task-1", 0.5),
    ("Task-2", 0.5),
    ("Task-3", 0.5),
]

def simulate_io(task_info):
    task_name, duration = task_info
    print(f"Starting: {task_name}")
    time.sleep(duration)  # Simulate I/O
    return f"{task_name}: completed in {duration}s"

print(f"Processing {len(tasks)} tasks with ThreadPoolExecutor (max_workers=3)\n")
start = time.time()

with ThreadPoolExecutor(max_workers=3) as pool:
    results = pool.map(simulate_io, tasks)
    for result in results:
        print(f"  {result}")

elapsed = time.time() - start
print(f"\nTotal time: {elapsed:.2f}s")
