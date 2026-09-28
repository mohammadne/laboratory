"""Learn the basics of Python streams.

Run from this directory with:
    python3 stream_basics.py

A stream is an object that lets you read or write data gradually, instead of
needing all of that data in memory at once. Files, HTTP responses, sockets,
and `io.StringIO` are common examples.
"""

from io import BytesIO, StringIO
from pathlib import Path


def text_stream_example() -> None:
    print("\n1. Text streams")

    # StringIO behaves like an open *text file*, but stores its data in memory.
    # It is ideal for experimenting because it does not create a real file.
    stream = StringIO("first line\nsecond line\nthird line\n")

    # read(n) takes at most n characters and moves the current position forward.
    print("read(5):", repr(stream.read(5)))
    print("position after read:", stream.tell())

    # seek(0) moves back to the beginning, so future reads start there again.
    stream.seek(0)
    print("readline():", repr(stream.readline()))

    # A text stream is iterable: this is memory-friendly for large files.
    for line in stream:
        print("line:", line.strip())

    stream.close()


def binary_stream_example() -> None:
    print("\n2. Binary streams")

    # BytesIO is the binary equivalent of StringIO. Binary streams read/write
    # `bytes`, whereas text streams read/write `str`.
    stream = BytesIO()
    stream.write(b"hello ")
    stream.write(b"world")

    stream.seek(0)
    print("all bytes:", stream.read())
    stream.close()


def file_stream_example() -> None:
    print("\n3. Reading a file in chunks")

    # `with` always closes the file, even if an error occurs inside the block.
    # This example reads this source file a little at a time—not all at once.
    source_file = Path(__file__)
    chunk_size = 40
    bytes_read = 0

    with source_file.open("rb") as stream:
        while True:
            chunk = stream.read(chunk_size)

            # `read()` returns b"" at end-of-file. It is falsy, so stop here.
            if not chunk:
                break

            bytes_read += len(chunk)
            # Decoding is only for displaying this text source file.
            preview = chunk.decode("utf-8", errors="replace").replace("\n", "\\n")
            print(f"read {len(chunk):2} bytes: {preview!r}")

    print("total bytes read:", bytes_read)


def generator_stream_example() -> None:
    print("\n4. A generator as a stream of values")

    # Generators yield one value at a time. Unlike a list, they can represent
    # a very large—or even endless—sequence without storing every value.
    def numbers():
        for number in range(1, 4):
            yield number

    for number in numbers():
        print("received:", number)


if __name__ == "__main__":
    text_stream_example()
    binary_stream_example()
    file_stream_example()
    generator_stream_example()
