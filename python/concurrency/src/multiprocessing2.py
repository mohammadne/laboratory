import time
from concurrent.futures import ProcessPoolExecutor

def calculate(n):
    return sum(i * i for i in range(n))

def main():
    print("=== ProcessPoolExecutor: Map and Submit ===\n")

    print("Using ProcessPoolExecutor with map():")
    start = time.time()
    with ProcessPoolExecutor(max_workers=4) as pool:
        results = pool.map(
            calculate,
            [10_000_000] * 8,
        )
        for count, result in enumerate(results, start=1):
            print(f"  Result {count}: {result}")

    elapsed = time.time() - start
    print(f"Map completed in {elapsed:.2f}s\n")

    print("Using ProcessPoolExecutor with submit():")
    start = time.time()
    with ProcessPoolExecutor(max_workers=4) as pool:
        # Submit individual tasks
        futures = [
            pool.submit(calculate, 10_000_000)
            for _ in range(8)
        ]

        # Get results as they complete
        for i, future in enumerate(futures):
            result = future.result()
            print(f"  Result {i+1}: {result}")

    elapsed = time.time() - start
    print(f"Submit completed in {elapsed:.2f}s\n")

if __name__ == "__main__":
    main()
