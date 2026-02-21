#!/bin/bash

#
# build-sovereign-ai-lab.sh
#
# This script is designed to set up a lab environment for running
# large language models (LLMs) using Ollama on an Ubuntu system. 
#
# 20210220 - 2300
#

# 1. Update Repositories, Install Drivers, and Build Utilities
sudo apt update && sudo apt upgrade -y
sudo ubuntu-drivers autoinstall
sudo apt install nvidia-utils-565-server nvtop btop -y
sudo apt install build-essential git gcc cmake curl -y

# 2. Install Python Environment and Development Utilities
sudo apt install python3-pip python3-venv python3-dev -y
#sudo reboot

# 3. Install Ollama
curl -fsSL https://ollama.com/install.sh | sh

# 4. Verify Installation
#systemctl status ollama

# 5. Pull an LLM (IBM Granite 3.3 8B)
ollama pull granite3.3:8b

# 6. Run the LLM
# ollama run granite3.3:8b
