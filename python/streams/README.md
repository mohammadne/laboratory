# Python streams: a small lesson

A stream delivers data over time. That lets you process a large file, a network response, or live data without first loading the complete result into memory.

Run the example:

```bash
cd /Users/mohammadne/Workspace/personal/laboratory/python/streams
python3 stream_basics.py
```

It demonstrates:

- text streams (`StringIO`) and binary streams (`BytesIO`)
- `read()`, `readline()`, `tell()`, and `seek()`
- the usual pattern for reading a file chunk by chunk
- generators as value streams

## Rules of thumb

- Use text mode (`"r"`, `"w"`) for characters/strings; use binary mode (`"rb"`, `"wb"`) for raw bytes such as images.
- Prefer `with open(...) as stream:` so files are reliably closed.
- Iterate by line for text files, or use `read(chunk_size)` for binary/large data.
- For network streams, apply the same chunking idea; wait for each chunk and process it before asking for the next.

SSE, the previous example, is a network text stream: the server keeps an HTTP response open and sends event records as new data becomes available.
