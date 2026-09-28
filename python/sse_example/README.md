# Minimal Python SSE example

SSE is a one-way, long-lived HTTP connection: the server continuously pushes events to the browser. The browser receives them using `EventSource`.

Run it without installing anything:

```bash
cd sse_example
python3 server.py
```

Open <http://localhost:8000>. The server emits five JSON events, one per second. The key SSE detail is the `data: ...\n\n` format; the blank line marks the end of an event.
