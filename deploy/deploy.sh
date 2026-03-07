#!/bin/bash
set -euo pipefail

: "${TAG:?Missing TAG}"

source ./.env

COMPOSE_FILE="docker-compose.$ENV.yml"

echo "Deploying $IMAGE:$TAG"

echo "$TOKEN" | docker login ghcr.io -u "$USER" --password-stdin

docker compose -f "$COMPOSE_FILE" pull
docker compose -f "$COMPOSE_FILE" -p "$ENV" up -d
