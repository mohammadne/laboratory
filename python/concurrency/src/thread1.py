import threading
import time

print("=== Threading: I/O-bound operations ===\n")

def work(thread_id, duration=1):
    print(f"[{thread_id}] starting work")
    time.sleep(duration)  # Simulate I/O operation
    print(f"[{thread_id}] work complete (slept {duration}s)")
    print(f"[{thread_id}] finishing work")

print("Creating and starting threads...")
start = time.time()

t1 = threading.Thread(target=work, args=(1, 1))
t2 = threading.Thread(target=work, args=(2, 1))

t1.start()  # starts the thread.
t2.start()  # starts the thread.

t1.join()   # waits for it to finish.
t2.join()   # waits for it to finish.

elapsed = time.time() - start
print(f"\nTotal time: {elapsed:.2f}s")
