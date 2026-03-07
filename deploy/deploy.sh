#!/bin/bash
set -euo pipefail

: "${TAG:?Missing TAG}"

source ./.env

mkdir -p .deploy >/dev/null 2>&1
touch .deploy/current
cp .deploy/current .deploy/previous
echo "$TAG" > .deploy/current

COMPOSE_FILE="docker-compose.$ENV.yml"

echo "Deploying $IMAGE:$TAG"

echo "$TOKEN" | docker login ghcr.io -u "$USER" --password-stdin

docker compose -f "$COMPOSE_FILE" pull
docker compose -f "$COMPOSE_FILE" -p "$ENV" up -d
