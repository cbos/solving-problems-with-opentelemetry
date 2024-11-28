# Insights with OpenTelemetry

This repo contains the demos of my talk 'How I solved production issues with OpenTelemetry (and how you can too)'


## Prerequisites

- Java (can be installed with `sdk install java`)
- [Just commandrunner](https://just.systems/man/en) 
- Docker or [Podman](https://podman.io/)


## Run locally

```shell

# Compile java code
./mvnw verify

# Download OpenTelemetry jar
just download-otel

# Start setup
just up

```