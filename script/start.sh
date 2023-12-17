#!/bin/sh

# Function to exit the script and kill the background process gracefully
exit_proc() {
    kill -SIGTERM $child_pid
}

# Function to perform cleanup and exit
finish() {
    exit_proc
    exit 0
}

# Set trap for signals to invoke the 'finish' function
trap finish SIGTERM SIGINT SIGQUIT

# Extract binary and additional arguments
bin="$1"
shift
extArgs="$@"

echo "-----------------------------------------------------"
echo "Starting $bin with args: $extArgs"
echo "-----------------------------------------------------"

# Execute the binary with arguments in the background
$bin $extArgs 2>&1 &
child_pid=$!

# Wait for the background process to terminate gracefully
wait $child_pid

# Keep the container running with a lightweight process
while true; do
    sleep 1
done