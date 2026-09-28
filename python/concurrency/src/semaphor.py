import asyncio
import time

print("=== Asyncio Semaphore ===")
print("Max 3 concurrent requests\n")

semaphore = asyncio.Semaphore(3)

async def call_api(name):
    print(f"{name}: waiting...")
    async with semaphore:
        print(f"{name}: acquired semaphore")
        await asyncio.sleep(1)
        print(f"{name}: released semaphore")
    return f"{name}: done"

async def main():
    tasks = [call_api(f"Request-{i}") for i in range(8)]
    results = await asyncio.gather(*tasks)
    for result in results:
        print(result)

asyncio.run(main())
