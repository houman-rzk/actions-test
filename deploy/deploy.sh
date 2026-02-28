#!/bin/bash
set -euo pipefail

: "${IMAGE:?Missing IMAGE}"
: "${TAG:?Missing TAG}"
: "${ENV:?Missing ENV}"
: "${TOKEN:?Missing TOKEN}"
: "${USER:?Missing USER}"

COMPOSE_FILE="docker-compose.$ENV.yml"

echo "Deploying $IMAGE:$TAG"

echo "$TOKEN" | docker login ghcr.io -u "$USER" --password-stdin

docker compose -f "$COMPOSE_FILE" pull
docker compose -f "$COMPOSE_FILE" -p "$ENV" up -d
