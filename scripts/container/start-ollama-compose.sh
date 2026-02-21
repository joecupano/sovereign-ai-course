#!/bin/bash

#
# start-ollama-compose.sh
#
# Prepares persistent storage and starts Ollama via Docker Compose.
# Optionally pulls a default model using the compose init profile.
#

set -euo pipefail

BASE_DATA_DIR="/opt/sovereign-ai-lab"
OLLAMA_DATA_DIR="${BASE_DATA_DIR}/ollama"
RAG_DATA_DIR="${BASE_DATA_DIR}/rag"
COMPOSE_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/docker-compose.ollama.yml"

SKIP_MODEL_PULL="false"
if [[ "${1:-}" == "--skip-model-pull" ]]; then
  SKIP_MODEL_PULL="true"
fi

if ! command -v docker >/dev/null 2>&1; then
  echo "Error: Docker is not installed. Install Docker first or run scripts/install-sovereign-ai-lab-ollama-container.sh"
  exit 1
fi

sudo mkdir -p "${OLLAMA_DATA_DIR}"
sudo mkdir -p "${RAG_DATA_DIR}/documents" "${RAG_DATA_DIR}/embeddings" "${RAG_DATA_DIR}/vectorstore"
sudo chown -R "$USER":"$USER" "${BASE_DATA_DIR}"

docker compose -f "${COMPOSE_FILE}" up -d

if [[ "${SKIP_MODEL_PULL}" == "false" ]]; then
  docker compose -f "${COMPOSE_FILE}" --profile init run --rm ollama-model-init
fi

echo ""
echo "Ollama is running with persistent storage."
echo "API: http://localhost:11434"
echo "Ollama data: ${OLLAMA_DATA_DIR}"
echo "RAG data: ${RAG_DATA_DIR}"
