import asyncio, time

def worker_sync(name):
    print(name, "start")
    time.sleep(1)
    print(name, "done")

async def worker(name):
    print(name, "start")
    await asyncio.sleep(1)
    # time.sleep(1) -> This would block the event loop, preventing other tasks from running.
    print(name, "done")

async def main():
    await worker("D")

    await asyncio.to_thread(worker_sync, "H")

    await asyncio.gather(
        worker("A"),
        worker("B"),
        worker("C"),
    )

    task = asyncio.create_task(worker("E"))
    await task

    async with asyncio.TaskGroup() as tg:
        tg.create_task(worker("F"))
        tg.create_task(worker("G"))

asyncio.run(main())
