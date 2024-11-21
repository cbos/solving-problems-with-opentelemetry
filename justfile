# Just file
# Documentation: https://just.systems/man/en/
# Cheatsheet: https://cheatography.com/linux-china/cheat-sheets/justfile/

set dotenv-required
set dotenv-load := true

# Podman or Docker executable
PODMAN_COMPOSE := "podman-compose"
DOCKER_COMPOSE := "docker compose"
COMPOSE_FILE := "-f docker/docker-compose.yml"

# Check if the podman is available
CONTAINER_EXECUTABLE := if shell('command -v ' + PODMAN_COMPOSE ) != "" { PODMAN_COMPOSE } else { DOCKER_COMPOSE }

# List of command
default:
  @just --list

# Build the demo app
build:
    ./mvnw verify

# Download (and overwrite) OpenTelemetry autoinstrument jar
download-otel:
    @mkdir -p .otel
    @echo "Download opentelemetry java instrumentation jar version $OTEL_VERSION"
    curl -sL -o .otel/opentelemetry-javaagent.jar "https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v$OTEL_VERSION/opentelemetry-javaagent.jar"
    ls -lh .otel/

# Start services (and build if needed)
up:
    {{CONTAINER_EXECUTABLE}} {{COMPOSE_FILE}} up -d --build

# Bring the stack down
down:
    {{CONTAINER_EXECUTABLE}} {{COMPOSE_FILE}} down

# Show the current status
@ps:
    {{CONTAINER_EXECUTABLE}} {{COMPOSE_FILE}} ps

# Show the logs of the service provided as parameter
@logs SERVICE:
    {{CONTAINER_EXECUTABLE}} {{COMPOSE_FILE}} logs {{SERVICE}}