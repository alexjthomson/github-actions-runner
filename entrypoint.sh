#!/bin/bash

# Exit on errors
set -e

# Validate environment variables:
if [ -z "$GITHUB_URL" ] || [ -z "$RUNNER_TOKEN_FILE" ]; then
    echo "GITHUB_URL and RUNNER_TOKEN_FILE must be set"
    exit 1
fi

RUNNER_TOKEN=$(cat "$RUNNER_TOKEN_FILE")
RUNNER_NAME=${RUNNER_NAME:-unnamed}

# Configure the runner:
if [ ! -f .runner ]; then
    ./config.sh --url "$GITHUB_URL" --token "$RUNNER_TOKEN" --name "$RUNNER_NAME" --unattended --replace
fi

# Start the runner:
exec ./run.sh