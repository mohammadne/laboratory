```txt
                    Python Concurrency
                           │
          ┌────────────────┼────────────────┐
          │                │                │
       asyncio          Threads         Processes
          │                │                │
      async/await       threading      multiprocessing
          │                │                │
      Event Loop           GIL          Separate GILs
          │                │                │
      I/O-bound         I/O-bound        CPU-bound
```

| Mechanism            | Concurrent | Parallel CPU execution    |
| -------------------- | ---------- | ------------------------- |
| `asyncio`            | ✅          | ❌                         |
| `threading`          | ✅          | Usually ❌ for Python code |
| `multiprocessing`    | ✅          | ✅                         |
| `concurrent.futures` | depends    | depends                   |

Use threading when:
- You call blocking libraries that do not support async APIs.
- You have a modest number of concurrent operations.
- You need to integrate with code designed around threads.
Use asyncio when:
- You need many concurrent network/socket/database operations.
- The libraries you use offer async support.
- You want predictable concurrency without many locks.

threading.Thread creates real OS threads.

The event loop is the scheduler at the center of asyncio.

`threading.Lock` protects shared state between OS threads.
`asyncio.Lock` protects shared state between asyncio tasks.

Future states visualization:

```txt
Future
  │
  ├── pending
  │
  ├── running
  │
  └── completed
          │
          ├── result
          └── exception
```

## Examples in `src/`

### 1. **concurent.py** - Asyncio Basics
Demonstrates different ways to run async tasks:
- Single task execution
- Running sync code in thread with `asyncio.to_thread()`
- Running multiple tasks concurrently with `asyncio.gather()`
- Creating and awaiting individual tasks
- Using `asyncio.TaskGroup()` for modern task management

**When to use**: I/O-bound operations (network requests, file I/O, database queries)

### 2. **locking.py** - Thread-Safe Shared State
Demonstrates synchronization primitives to protect shared data:
- `asyncio.Lock` for protecting shared state in async code
- `threading.Lock` for protecting shared state in threaded code

**When to use**: When multiple threads/tasks access the same data

### 3. **multiprocessing1.py** - Basic Multiprocessing
Demonstrates process creation and management:
- Creating multiple processes for CPU-bound tasks
- Starting and joining processes
- Each process runs independently with its own GIL

**When to use**: CPU-intensive computations (data processing, calculations)

### 4. **multiprocessing2.py** - ProcessPoolExecutor
Demonstrates high-level process pool abstraction:
- Using `executor.map()` for batch processing
- Using `executor.submit()` for individual task submission
- Futures API for tracking task states (pending, running, completed)

**When to use**: CPU-bound work with variable number of tasks

### 5. **queue_example.py** - Producer-Consumer Pattern
Demonstrates thread-safe communication between threads:
- `queue.Queue` for thread-based producers and consumers
- `asyncio.Queue` for async-based producers and consumers
- Shows blocking/async behavior differences

**When to use**: Coordinating work between threads/tasks with buffering

### 6. **sem.py** - Semaphores
Demonstrates rate limiting and resource pooling:
- Limiting concurrent access to N resources
- Asyncio semaphore for limiting concurrent tasks

**When to use**: API rate limiting, connection pool limits, resource constraints

### 7. **thread1.py** - Basic Threading
Demonstrates basic thread creation:
- Creating and starting threads
- Thread.join() to wait for completion
- Good for I/O-bound operations

**When to use**: I/O-bound work (network, file operations)

### 8. **thread2.py** - ThreadPoolExecutor
Demonstrates high-level thread pool abstraction:
- Creating a pool of reusable worker threads
- Using executor.map() for batch I/O operations
- More convenient than manual thread management

**When to use**: Multiple I/O-bound tasks

### 9. **timeout.py** - Timeout Handling
Demonstrates timeout management:
- `asyncio.timeout()` context manager
- Catching `asyncio.TimeoutError`
- Cancelling operations that exceed time limits

**When to use**: Preventing operations from hanging indefinitely

## Quick Decision Tree

```
Is your task CPU-bound?
├─ Yes → Use multiprocessing or ProcessPoolExecutor
└─ No (I/O-bound) → 
   ├─ Need to write async/await? → Use asyncio
   ├─ Simple and straightforward? → Use threading
   └─ Multiple tasks? → Use ThreadPoolExecutor
```

## Running the Examples

```bash
# Asyncio examples
python3 concurent.py
python3 timeout.py
python3 sem.py
python3 locking.py
python3 queue_example.py

# Threading examples
python3 thread1.py
python3 thread2.py

# Multiprocessing examples
python3 multiprocessing1.py
python3 multiprocessing2.py
```
