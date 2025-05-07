# Insights with OpenTelemetry
![Badge](https://goto.ceesbos.nl/badge/github/cbos/solving-problems-with-opentelemetry)

This repo contains the demos of my talk 'How I solved production issues with OpenTelemetry (and how you can too)'


## Prerequisites

- Java (can be installed with `sdk install java`)
- [Just commandrunner](https://just.systems/man/en) 
- Docker or [Podman](https://podman.io/)

## Run locally

```shell

# Compile java code
just build

# Download OpenTelemetry jar
just download-otel

# Start setup
just up

# Check the logs 
just logs alpha
just logs beta

# check the status of the services
just ps

#Execute one or more scenarios
 just k6-scenario-1
 just k6-scenario-2
 just k6-scenario-3

# Stop all services
just down
```