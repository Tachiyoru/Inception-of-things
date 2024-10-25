#!/bin/bash
sudo apt update
sudo apt install ca-certificates curl -y

# Variables
SERVER_IP=$1

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Installer K3d sur le serveur
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# Attendre que K3d soit complètement installé
sleep 10
