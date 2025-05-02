#!/usr/bin/env bash
set -euo pipefail

# 1.1. Add Docker’s official GPG key & repo
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

# 1.2. Install Docker Engine, CLI, and Compose plugin
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# 1.3. (Optional) Allow your user to run docker without sudo
sudo usermod -aG docker $USER
# then log out and back in (or `newgrp docker`)

# 1.4. Verify Docker installation
sudo docker run hello-world

# 1.5. Install Docker Compose
sudo apt install -y docker-compose
