# Sovereign AI Course
Lectures, labs, and resources for a comprehensive course on Sovereign AI — from governance frameworks to hands-on system deployment.

# Introduction

The purpose of this curriculum is to **ground AI in reality.** By shifting the focus from "prompt engineering" to the **Supply Chain and Technical Stack**, students will move from being passive consumers of AI to informed architects of technology. This course aims to provide a "dirt-to-data" understanding tracing the journey of an AI solution from the rare earth minerals mined for hardware to the specialized Linux environments where Large Language Models (LLMs) are deployed.

The technology stack referenced in the labs includes a **Dell Precision 3620** with **64GB RAM** and **NVIDIA RTX 3050** GPU with **Ubuntu** operating system and **Ollama** for local model orchestration. The choice behind the hardware started with what was available but after experimentation the cumulative hardware specifications reflect a good platform for visible demonstration of performance differences between CPU and GPU. It is not necessary to use the exact hardware but be sure to use hardware with similar cumulative hardware specifications. The software choices are open source with the choice of LLM specified only limited in size of up to 8B.

Choosing which LLMs to use depends on how much you choose to focus on ethics. For a curriculum focused on the "AI Stack and Supply Chain," you want models that provide a paper trail for their data and training. The LLM you choose for the lab will be addressed in the relevant curriculum section.

# Lectures and Labs
Go to the [wiki](https://github.com/joecupano/sovereign-ai-course/wiki)

# Install Scripts

- NVIDIA host install: `scripts/build-sovereign-ai-lab.sh`
- AMD host install: `scripts/build-sovereign-ai-lab _amd.sh`
- Ollama container + persistent RAG storage: `scripts/install-sovereign-ai-lab-ollama-container.sh`
- Docker Compose variant: `scripts/docker-compose.ollama.yml`
- Compose helper script: `scripts/start-ollama-compose.sh`
- Compose stop script: `scripts/stop-ollama-compose.sh`

## Docker Compose (Ollama + Persistent RAG Storage)

```bash
sudo mkdir -p /opt/sovereign-ai-lab/ollama
sudo mkdir -p /opt/sovereign-ai-lab/rag/documents /opt/sovereign-ai-lab/rag/embeddings /opt/sovereign-ai-lab/rag/vectorstore
sudo chown -R "$USER":"$USER" /opt/sovereign-ai-lab

docker compose -f scripts/docker-compose.ollama.yml up -d
docker compose -f scripts/docker-compose.ollama.yml --profile init run --rm ollama-model-init

# Or run the helper script (does mkdir/chown + compose up + model pull)
./scripts/start-ollama-compose.sh

# Skip default model pull
./scripts/start-ollama-compose.sh --skip-model-pull

# Stop compose services (keeps persistent data)
./scripts/stop-ollama-compose.sh
```

Ollama API endpoint:
- `http://localhost:11434`

Persistent paths:
- `/opt/sovereign-ai-lab/ollama`
- `/opt/sovereign-ai-lab/rag`
