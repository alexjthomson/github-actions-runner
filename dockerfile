FROM ubuntu:22.04

# Install dependencies:
RUN apt-get update && apt-get install -y \
    curl \
    jq \
    git \
    ca-certificates \
    && apt-get clean

# Configure filesystem:
COPY entrypoint.sh /entrypoint.sh
RUN mkdir -p /runner && \
    chmod +x /entrypoint.sh
WORKDIR /runner

# Download the GitHub Actions runner:
RUN curl -o actions-runner.tar.gz -L https://github.com/actions/runner/releases/download/v2.321.0/actions-runner-linux-x64-2.321.0.tar.gz && \
    tar xzf actions-runner.tar.gz && \
    rm -f actions-runner.tar.gz

# Install dependencies for .NET Core:
RUN ./bin/installdependencies.sh

# Create runner user:
RUN useradd -m runner && \
    chown -R runner:runner /runner
USER runner

# Entry point:
ENTRYPOINT ["/entrypoint.sh"]