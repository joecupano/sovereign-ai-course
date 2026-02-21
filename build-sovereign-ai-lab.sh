#!/bin/bash

#
# build-sovereign-ai-lab.sh
#
# This script is designed to set up a lab environment for running
# large language models (LLMs) using Ollama on an Ubuntu system. 
#
# 20210220 - 2300
#

BANNER_COLOR="\e[0;104m\e[K"   # blue
BANNER_RESET="\e[0m"


cat <<'EOF'

With Ubuntu fresh install, this script sets up the environment performing
the following in order:

1. Update Repositories
2. Install Ubuntu Drivers
3. Install NVIDIA Drivers and Utilities
4. Install Build Utilities
5. Install Python Environment and Development Utilities
6. Install Ollama
7. Pull an LLM (IBM Granite 3.3 8B)

Starting ...
EOF

echo " "
echo -e "${BANNER_COLOR}"
echo -e "${BANNER_COLOR} 1. Update Repositories"
echo -e "${BANNER_COLOR}"
echo -e "${BANNER_RESET}"
echo " "
sudo apt update && sudo apt upgrade -y
echo " "
echo -e "${BANNER_COLOR}"
echo -e "${BANNER_COLOR} 2, Install Ubuntu Drivers"
echo -e "${BANNER_COLOR}"
echo -e "${BANNER_RESET}"
echo " "
sudo ubuntu-drivers autoinstall
echo " "
echo -e "${BANNER_COLOR}"
echo -e "${BANNER_COLOR} 3. Install NVIDIA Drivers and Utilities$"
echo -e "${BANNER_COLOR}"
echo -e "${BANNER_RESET}"
echo " "
sudo apt install nvidia-utils-565-server nvtop btop -y
echo " "
echo -e "${BANNER_COLOR}"
echo -e "${BANNER_COLOR} 4. Install Build Utilities"
echo -e "${BANNER_COLOR}"
echo -e "${BANNER_RESET}"
echo " "
sudo apt install build-essential git gcc cmake curl -y

echo " "
echo -e "${BANNER_COLOR}"
echo -e "${BANNER_COLOR} 5. Install Python Environment and Development Utilities$"
echo -e "${BANNER_COLOR}"
echo -e "${BANNER_RESET}"   
echo " "
sudo apt install python3-pip python3-venv python3-dev -y

echo " "
echo -e "${BANNER_COLOR}"
echo -e "${BANNER_COLOR} 6. Install Ollama$"
echo -e "${BANNER_COLOR}"
echo -e "${BANNER_RESET}"
echo " "
curl -fsSL https://ollama.com/install.sh | sh

#systemctl status ollama

echo " "
echo -e "${BANNER_COLOR}"
echo -e "${BANNER_COLOR} 7. Pull an LLM (IBM Granite 3.3 8B)$"
echo -e "${BANNER_COLOR}"
echo -e "${BANNER_RESET}"   
echo " "
ollama pull granite3.3:8b

cat <<'EOF'

With evertything installed, you can now run the LLM using
the following command to enter a chat promp session with the model:"

ollama run granite3.3:8b

Enjoy !

EOF



