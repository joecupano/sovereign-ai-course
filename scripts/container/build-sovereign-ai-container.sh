#!/bin/bash

#
# install-sovereign-ai-lab-ollama-container.sh
#
# Installs Docker (if needed) and runs Ollama as a container with
# persistent storage for model files and RAG assets.
#
# 20260221
#

set -euo pipefail

INSTALL_COLOR="\e[0;104m\e[K"   # blue
SUCCESS_COLOR="\e[0;42m\e[K"     # green
BANNER_RESET="\e[0m"

BASE_DATA_DIR="/opt/sovereign-ai-lab"
OLLAMA_DATA_DIR="${BASE_DATA_DIR}/ollama"
RAG_DATA_DIR="${BASE_DATA_DIR}/rag"
DEFAULT_MODEL="granite3.3:8b"

print_banner() {
  echo " "
  echo -e "${INSTALL_COLOR}"
  echo -e "${INSTALL_COLOR} $1"
  echo -e "${INSTALL_COLOR}"
  echo -e "${BANNER_RESET}"
  echo " "
}

print_banner "Install Sovereign AI Lab (Ollama Container + Persistent RAG Storage)"

cat <<EOF

This script performs the following:

1. Update package repositories
2. Install Docker engine (if missing)
3. Configure Docker service
4. Create persistent storage directories
5. Pull and run the Ollama container
6. Pull default model (${DEFAULT_MODEL})

Persistent paths created:
- ${OLLAMA_DATA_DIR}        (Ollama models/config)
- ${RAG_DATA_DIR}/documents (raw documents)
- ${RAG_DATA_DIR}/embeddings (saved embeddings)
- ${RAG_DATA_DIR}/vectorstore (vector DB files)

Starting ...

EOF

echo "Press any key to continue or Ctrl-C to exit..."
read -n 1 -s -r
echo " "

print_banner "1. Update repositories"
sudo apt update && sudo apt upgrade -y

print_banner "2. Install Docker engine"
if ! command -v docker >/dev/null 2>&1; then
  sudo apt install -y docker.io ca-certificates curl
else
  echo "Docker already installed."
fi

print_banner "3. Configure Docker service"
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker "$USER" || true

print_banner "4. Create persistent storage directories"
sudo mkdir -p "${OLLAMA_DATA_DIR}"
sudo mkdir -p "${RAG_DATA_DIR}/documents" "${RAG_DATA_DIR}/embeddings" "${RAG_DATA_DIR}/vectorstore"
sudo chown -R "$USER":"$USER" "${BASE_DATA_DIR}"

print_banner "5. Pull and run the Ollama container"
sudo docker pull ollama/ollama:latest

if sudo docker ps -a --format '{{.Names}}' | grep -xq ollama; then
  echo "Existing ollama container found. Replacing it to apply latest config."
  sudo docker rm -f ollama
fi

sudo docker run -d \
  --name ollama \
  --restart unless-stopped \
  -p 11434:11434 \
  -v "${OLLAMA_DATA_DIR}:/root/.ollama" \
  -v "${RAG_DATA_DIR}:/rag-data" \
  ollama/ollama:latest

print_banner "6. Pull default model (${DEFAULT_MODEL})"
sudo docker exec ollama ollama pull "${DEFAULT_MODEL}"

echo " "
echo -e "${SUCCESS_COLOR}                                                        "

cat <<EOF

Install complete.

Ollama API endpoint:
- http://localhost:11434

Container:
- ollama

Persistent data:
- ${OLLAMA_DATA_DIR}
- ${RAG_DATA_DIR}

Helpful commands:
- sudo docker logs -f ollama
- sudo docker exec -it ollama ollama list
- sudo docker exec -it ollama ollama run ${DEFAULT_MODEL}

Note: Docker group membership takes effect after re-login or reboot.

EOF

echo -e "${SUCCESS_COLOR}                                                        "
echo -e "${BANNER_RESET}"
echo " "
