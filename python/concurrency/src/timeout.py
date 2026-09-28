import asyncio

print("=== Asyncio Timeout ===\n")

async def quick_operation():
    print("Quick operation: starting...")
    await asyncio.sleep(1)
    print("Quick operation: completed!")
    return "success"

async def slow_operation():
    print("Slow operation: starting...")
    await asyncio.sleep(10)
    print("Slow operation: completed!")
    return "success"

async def main():
    # This will succeed
    print("Test 1: Quick operation with 5 second timeout")
    try:
        async with asyncio.timeout(5):
            result = await quick_operation()
            print(f"Result: {result}\n")
    except asyncio.TimeoutError:
        print("Operation timed out!\n")

    # This will timeout
    print("Test 2: Slow operation with 2 second timeout")
    try:
        async with asyncio.timeout(2):
            result = await slow_operation()
            print(f"Result: {result}\n")
    except asyncio.TimeoutError:
        print("Operation timed out!\n")

asyncio.run(main())
