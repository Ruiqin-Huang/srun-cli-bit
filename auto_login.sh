#!/bin/bash

# Swtich to the script's directory to ensure relative paths work
cd "$(dirname "$0")"

# Path to the executable
# User specified path: ./bin/srun-bit-windows-linux.bin
CMD="./bin/srun-bit-windows-linux.bin"

# Interval in seconds (30 minutes)
INTERVAL=1800

while true; do
    echo "----------------------------------------------------------------"
    echo "Current Time: $(date)"
    
    if [ -f "$CMD" ]; then
        echo "Executing: $CMD login"
        $CMD login
    else
        echo "Error: Binary file not found at $CMD"
        echo "Attempting to run python source as fallback..."
        if [ -f "src/main.py" ]; then
             python3 src/main.py login
        else
             echo "Error: Source code not found either."
        fi
    fi
    
    echo "Waiting for 30 minutes before next login attempt..."
    sleep $INTERVAL
done
