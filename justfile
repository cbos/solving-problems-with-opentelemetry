# Just file
# Documentation: https://just.systems/man/en/
# Cheatsheet: https://cheatography.com/linux-china/cheat-sheets/justfile/

set dotenv-required
set dotenv-load := true

# Podman or Docker executable
PODMAN_COMPOSE := "podman-compose"
DOCKER_COMPOSE := "docker compose"

# Check if the podman is available
CONTAINER_EXECUTABLE := if shell('command -v ' + DOCKER_COMPOSE ) != "" { DOCKER_COMPOSE } else { PODMAN_COMPOSE }

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

# Use the selected executable in a recipe
start:
    {{CONTAINER_EXECUTABLE}} -f docker/docker-compose.yml up -d --build

down:
    {{CONTAINER_EXECUTABLE}} -f docker/docker-compose.yml down

@ps:
    {{CONTAINER_EXECUTABLE}} -f docker/docker-compose.yml ps

@log SERVICE:
    {{CONTAINER_EXECUTABLE}} -f docker/docker-compose.yml logs {{SERVICE}}