"""A dependency-free Server-Sent Events (SSE) example.

Run with: python server.py
Then open: http://localhost:8000
"""

from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
import json
import time


HERE = Path(__file__).parent


class SSEHandler(SimpleHTTPRequestHandler):
    def do_GET(self) -> None:
        if self.path == "/events":
            self.send_response(200)
            self.send_header("Content-Type", "text/event-stream")
            self.send_header("Cache-Control", "no-cache")
            self.send_header("Connection", "keep-alive")
            self.end_headers()

            # Each event is text in the SSE format: "data: ...\\n\\n".
            for number in range(1, 6):
                message = json.dumps({"number": number, "message": "Hello from Python!"})
                self.wfile.write(f"data: {message}\\n\\n".encode())
                self.wfile.flush()  # Send immediately instead of buffering it.
                time.sleep(1)
            return

        if self.path == "/":
            self.path = "/index.html"
        return super().do_GET()


if __name__ == "__main__":
    # Serve index.html from this example's directory.
    import os

    os.chdir(HERE)
    server = ThreadingHTTPServer(("localhost", 8000), SSEHandler)
    print("Open http://localhost:8000")
    server.serve_forever()
