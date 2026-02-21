#!/bin/bash

#
# build-sovereign-ai-lab.sh
#
# This script is designed to set up a lab environment for running
# large language models (LLMs) using Ollama on an Ubuntu system. 
#
# 20210220 - 2300
#

cat <<'EOF'

With Ubuntu fresh install, this script sets up the environment performing
the following in order:

1. Update Repositories, Install Drivers, and Build Utilities
2. Install Python Environment and Development Utilities
3. Install Ollama
4. Pull an LLM (IBM Granite 3.3 8B)

Starting ...
EOF
echo " "
echo "1. Update Repositories, Install Drivers, and Build Utilities"
echo " "
sudo apt update && sudo apt upgrade -y
sudo ubuntu-drivers autoinstall
sudo apt install nvidia-utils-565-server nvtop btop -y
sudo apt install build-essential git gcc cmake curl -y

echo " "
echo "2. Install Python Environment and Development Utilities"
echo " "
sudo apt install python3-pip python3-venv python3-dev -y

echo " "
echo "3. Install Ollama"
echo " "
curl -fsSL https://ollama.com/install.sh | sh

#systemctl status ollama

echo " "
echo "4. Pull an LLM (IBM Granite 3.3 8B)"
echo " "
ollama pull granite3.3:8b

cat <<'EOF'

With evertything installed, you can now run the LLM using
the following command to enter a chat promp session with the model:"

ollama run granite3.3:8b

Enjoy !

EOF



