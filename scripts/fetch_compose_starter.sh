#!/usr/bin/env bash
set -eu

# Determine script & project dirs
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CONFIGS_DIR="$PROJECT_ROOT/configs"

# What to fetch + where
COMPOSE_URL="https://raw.githubusercontent.com/debezium/debezium-examples/main/tutorial/docker-compose-mysql.yaml"
TMP_FILE="$CONFIGS_DIR/docker-compose-mysql.yaml"
FINAL_FILE="$CONFIGS_DIR/docker-compose.yml"

echo "📂  Ensuring configs/ exists…"
mkdir -p "$CONFIGS_DIR"

echo "⬇️   Downloading into configs/…"
curl -fSL -o "$TMP_FILE" "$COMPOSE_URL"

echo "✏️   Renaming to docker-compose.yml…"
mv "$TMP_FILE" "$FINAL_FILE"

echo "✅  Done!"
echo
echo "Next, from your project root run:"
echo
echo "    cd \"$PROJECT_ROOT\""
echo "    docker compose -f configs/docker-compose.yml up"
