#!/bin/bash
set -e

# 1. Start dockerd in the background
# We use nohup to detach it and & to run it asynchronously.
sudo nohup dockerd &

# 2. Wait for the Docker daemon to be fully available
# This loop checks the Docker status until it's ready.
until docker info >/dev/null 2>&1; do
  echo "Waiting for Docker daemon..."
  sleep 1
done

echo "Docker daemon is ready. Running setup script..."

# 3. Run your setup script
# The arguments are passed to ./setup.sh
./setup.sh "track.hyghj.eu.org"

echo "Setup complete. Keeping dockerd running in the foreground."

# 4. Bring the background dockerd process back to the foreground (PID 1)
# This uses the process ID we found earlier.
wait
