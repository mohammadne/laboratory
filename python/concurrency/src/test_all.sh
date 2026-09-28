#!/bin/bash

echo "Testing all concurrency examples..."
echo "===================================="
echo ""

for file in *.py; do
    echo "Testing: $file"
    if python3 "$file" > /dev/null 2>&1; then
        echo "  ✓ PASS"
    else
        echo "  ✗ FAIL"
    fi
done

echo ""
echo "===================================="
echo "All tests completed!"
