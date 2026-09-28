## Core idea

```text
`yield` produces a value and pauses a function.
`await` waits for an async operation without blocking the event loop.
```

## `yield` → generator

```python
def numbers():
    yield 1
    yield 2
```

This creates a generator: a source of multiple values.

```python
for n in numbers():
    print(n)
```

Use a normal generator with `for`.

## `async def` without `yield` → coroutine

```python
async def get_user():
    response = await fetch_user()
    return response
```

This creates a coroutine: one eventual result.

```python
user = await get_user()
```

Use it with `await`.

## `async def` with `yield` → async generator

```python
async def stream_numbers():
    for i in range(3):
        await asyncio.sleep(1)
        yield i
```

This creates an `AsyncGenerator`: multiple values that may become available over time.

```python
async for number in stream_numbers():
    print(number)
```

Use it with `async for`.

## Context managers

A context manager controls a resource lifetime:

```text
acquire → use → release
```

Normal context manager:

```python
with open("file.txt") as file:
    text = file.read()
```

Async context manager:

```python
async with session.get(url) as response:
    text = await response.text()
```

It has these methods:

```python
async def __aenter__(self): ...
async def __aexit__(self, exc_type, exc, tb): ...
```

## `@asynccontextmanager`

It converts a special async generator into an async context manager:

```python
from contextlib import asynccontextmanager

@asynccontextmanager
async def resource():
    value = await acquire()

    try:
        yield value
    finally:
        await release(value)
```

```python
async with resource() as item:
    await use(item)
```

Meaning:

```text
before `yield` → enter/setup
`yield value`  → `item` after `as`
after `yield`  → exit/cleanup
```

The object returned by `resource()` has `__aenter__` and `__aexit__`. The yielded `value` does not need those methods.

## `for` versus `async for`

```python
for item in iterable:
    ...
```

Uses a normal iterator:

```text
__iter__() / __next__()
```

```python
async for item in stream:
    ...
```

Uses an async iterator:

```text
__aiter__() / __anext__()
```

The next async item may require waiting; during that wait, other asyncio tasks can run.

## `with` versus `async with`

```python
with thing:
    ...
```

Uses:

```text
__enter__() / __exit__()
```

```python
async with thing:
    ...
```

Uses:

```text
__aenter__() / __aexit__()
```

Use `async with` when entering or cleaning up requires `await`: network sessions, database connections, async locks, and similar resources.

## Decorators

```python
@decorator
def function():
    ...
```

is approximately:

```python
function = decorator(function)
```

`@asynccontextmanager` is a decorator that changes an async generator from something you normally consume with `async for` into a resource manager used with `async with`.

## Cheat sheet

| Function form | Produces | Use |
|---|---|---|
| `def f(): return x` | regular value | `x = f()` |
| `def f(): yield x` | generator | `for x in f()` |
| `async def f(): return x` | coroutine | `x = await f()` |
| `async def f(): yield x` | async generator | `async for x in f()` |
| `@asynccontextmanager` + `async def f(): yield x` | async context manager | `async with f() as x` |
