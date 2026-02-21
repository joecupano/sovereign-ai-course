#!/bin/bash

#
# stop-ollama-compose.sh
#
# Stops and removes Ollama compose services while preserving persistent data.
#

set -euo pipefail

COMPOSE_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/docker-compose.ollama.yml"

if ! command -v docker >/dev/null 2>&1; then
  echo "Error: Docker is not installed."
  exit 1
fi

docker compose -f "${COMPOSE_FILE}" down

echo ""
echo "Ollama compose services stopped."
echo "Persistent data is preserved at:"
echo "- /opt/sovereign-ai-lab/ollama"
echo "- /opt/sovereign-ai-lab/rag"
