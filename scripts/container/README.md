# Container

- Ollama container + persistent RAG storage: build-sovereign-ai-container.sh`
- Docker Compose variant: docker-compose.ollama.yml
- Compose helper script: start-ollama-compose.sh
- Compose stop script: stop-ollama-compose.sh

## Docker Compose (Ollama + Persistent RAG Storage)

```bash
sudo mkdir -p /opt/sovereign-ai-lab/ollama
sudo mkdir -p /opt/sovereign-ai-lab/rag/documents /opt/sovereign-ai-lab/rag/embeddings /opt/sovereign-ai-lab/rag/vectorstore
sudo chown -R "$USER":"$USER" /opt/sovereign-ai-lab

docker compose -f docker-compose.ollama.yml up -d
docker compose -f docker-compose.ollama.yml --profile init run --rm ollama-model-init

# Or run the helper script (does mkdir/chown + compose up + model pull)
start-ollama-compose.sh

# Skip default model pull
start-ollama-compose.sh --skip-model-pull

# Stop compose services (keeps persistent data)
stop-ollama-compose.sh
```

Ollama API endpoint:
- `http://localhost:11434`

Persistent paths:
- `/opt/sovereign-ai-lab/ollama`
- `/opt/sovereign-ai-lab/rag`
