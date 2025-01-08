# GitHub Actions - Self Hosted Runner
This repository contains a self hosted Docker runner.

## Quick Start
Create a directory for the runner and create the following files:

## `token`
This file should contain the token for the runner.

## `docker-compose.yaml`
```yaml
name: github_runner
secrets:
  runner_token:
    file: ./token
services:
  github_runner:
    container_name: github_runner
    image: ghcr.io/alexjthomson/github-actions-runner:latest
    restart: unless-stopped
    secrets:
      - runner_token
    environment:
      RUNNER_TOKEN_FILE: /run/secrets/runner_token
      RUNNER_NAME: my_runner
      GITHUB_URL: https://github.com/myrepo

```

### Environment Variables
- `RUNNER_TOKEN_FILE`: Path to the file containing the runner token.
- `RUNNER_NAME` (optional): Name of the runner. This defaults to `unnamed` if
  none is provided.
- `GITHUB_URL`: URL that the runner runs at. You can use an organisation URL to
  allow the runner to run jobs for a range of repos.