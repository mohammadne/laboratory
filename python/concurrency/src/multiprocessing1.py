import time
from multiprocessing import Process

print("=== Multiprocessing: CPU-bound tasks ===\n")

def calculate(process_id, n):
    print(f"Process {process_id}: Starting calculation...")
    start = time.time()
    result = sum(i * i for i in range(n))
    elapsed = time.time() - start
    print(f"Process {process_id}: Result = {result}, Time = {elapsed:.2f}s")

if __name__ == "__main__":
    processes = [
        Process(target=calculate, args=(i, 10_000_000)) for i in range(4)
    ]

    start_time = time.time()
    for p in processes:
        p.start()

    for p in processes:
        p.join()

    total_time = time.time() - start_time
    print(f"\nTotal time: {total_time:.2f}s")
