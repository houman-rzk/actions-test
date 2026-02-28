#!/bin/bash
set -euo pipefail

: "${IMAGE:?Missing IMAGE}"
: "${TAG:?Missing TAG}"
: "${ENV:?Missing ENV}"
: "${TOKEN:?Missing TOKEN}"
: "${USER:?Missing USER}"

COMPOSE_FILE="docker-compose.$ENV.yml"

echo "Deploying $IMAGE:$TAG"

docker login ghcr.io -u "$USER" -p "$TOKEN"

export APP_IMAGE="$IMAGE"
export APP_TAG="$TAG"

docker compose -f "$COMPOSE_FILE" pull
docker compose -f "$COMPOSE_FILE" up -d

