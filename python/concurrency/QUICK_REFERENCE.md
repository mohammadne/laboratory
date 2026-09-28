# Python Concurrency Quick Reference

## Decision Matrix

| Task Type | Best Choice | Runner-up | Why |
|-----------|------------|-----------|-----|
| **I/O-bound** (network, file, DB) | `asyncio` | `ThreadPoolExecutor` | Lightweight, efficient I/O handling |
| **CPU-bound** (math, data processing) | `ProcessPoolExecutor` | `multiprocessing.Process` | True parallelism, bypass GIL |
| **Simple I/O tasks** | `ThreadPoolExecutor` | `asyncio` | Less code, easier to debug |
| **Complex async flows** | `asyncio` | N/A | Native async/await support |

## File Guide

### Core Concepts
- **concure.py** - Asyncio fundamentals (tasks, gather, TaskGroup)
- **locking.py** - Thread-safe state with Lock primitives
- **timeout.py** - Timeout handling and cancellation

### Threading (I/O-bound)
- **thread1.py** - Basic thread creation and joining
- **thread2.py** - ThreadPoolExecutor for multiple I/O tasks

### Multiprocessing (CPU-bound)
- **multiprocessing1.py** - Basic Process creation
- **multiprocessing2.py** - ProcessPoolExecutor with futures

### Coordination
- **queue_example.py** - Producer-consumer with Queue
- **sem.py** - Semaphore for rate limiting

### Performance
- **comparison.py** - Performance benchmarks of all approaches

## Common Patterns

### Pattern 1: Run Multiple I/O Tasks in Parallel
```python
# With ThreadPoolExecutor
with ThreadPoolExecutor(max_workers=5) as executor:
    results = executor.map(download, urls)

# With asyncio
async def main():
    await asyncio.gather(*[download(url) for url in urls])
```

### Pattern 2: Rate Limiting
```python
# With Semaphore
semaphore = asyncio.Semaphore(3)
async with semaphore:
    await api_call()
```

### Pattern 3: Producer-Consumer
```python
# With Queue
q = Queue()
# Producer
q.put(item)
# Consumer
item = q.get()
```

### Pattern 4: CPU-Bound Work
```python
# With ProcessPoolExecutor
with ProcessPoolExecutor(max_workers=4) as executor:
    results = executor.map(calculate, data)
```

### Pattern 5: Timeout Protection
```python
# With asyncio.timeout
async with asyncio.timeout(5):
    await long_operation()
```

## Performance Summary

### I/O-Bound (5 tasks × 0.5s each)
- Sequential: 2.5s
- Threading: 0.5s (5x faster) ✅
- Asyncio: 0.5s (5x faster) ✅
- Multiprocessing: 0.5s (overhead negates gains)

### CPU-Bound (4 tasks)
- Sequential: 1.5s
- Threading: 1.3s (minimal improvement due to GIL)
- Multiprocessing: 0.5s (3x faster) ✅

## When to Use What

### Use `asyncio` when:
- You have many I/O operations
- You're building web services (FastAPI, aiohttp)
- You need fine-grained control over concurrency
- You want to avoid thread overhead

### Use `threading` when:
- You have a few I/O operations
- You want simple, readable code
- You're not performance-critical
- Migrating from sync code is easier

### Use `multiprocessing` when:
- You have CPU-intensive work
- You need true parallelism
- GIL is a bottleneck
- You can afford process creation overhead

### Use `concurrent.futures` when:
- You want a simple, high-level API
- You're choosing between threads/processes
- You don't need async/await syntax

## GIL (Global Interpreter Lock)

**What it is**: Python mutex that prevents multiple threads from executing bytecode simultaneously

**Who cares**:
- Threads cannot run CPU-bound code in parallel (only concurrently)
- I/O operations release the GIL, allowing parallelism
- Multiprocessing bypasses GIL entirely

**Solution**: Use multiprocessing for CPU-bound work, threading/asyncio for I/O-bound work

## Common Gotchas

1. **Naming conflict**: Don't name your file `queue.py` - it shadows stdlib
2. **Multiprocessing guard**: Always use `if __name__ == "__main__":` for multiprocessing code
3. **Blocking in asyncio**: Using `time.sleep()` in async code blocks entire event loop
4. **Shared state**: Use Lock/Semaphore to protect mutable shared data
5. **Timeout errors**: Always catch `asyncio.TimeoutError` when using `asyncio.timeout()`

## Run All Examples

```bash
cd src/

# Quick tests
python3 concure.py          # Asyncio tasks
python3 locking.py          # Thread-safe state
python3 timeout.py          # Timeout handling
python3 sem.py              # Semaphore rate limiting

# I/O examples
python3 queue_example.py    # Producer-consumer
python3 thread1.py          # Basic threads
python3 thread2.py          # Thread pool

# CPU examples
python3 multiprocessing1.py # Basic processes
python3 multiprocessing2.py # Process pool

# Comparison
python3 comparison.py       # Performance benchmarks
```

## Further Reading

- Python docs: https://docs.python.org/3/library/concurrency.html
- asyncio tutorial: https://docs.python.org/3/library/asyncio.html
- threading docs: https://docs.python.org/3/library/threading.html
- multiprocessing docs: https://docs.python.org/3/library/multiprocessing.html
