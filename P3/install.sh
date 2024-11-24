#!/bin/bash
sudo apt update
sudo apt install ca-certificates curl -y

if command -v kubectl &> /dev/null; then
    echo "Kubectl installation found"
else
    curl -LO https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
    sudo chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
    kubectl version --client

    sleep 10
fi

if command -v docker &> /dev/null; then
    echo "Docker installation found"
else
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
fi

# Installer K3d sur le serveur
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

sleep 10