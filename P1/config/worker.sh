#!/bin/bash
sudo apt update
sudo apt install curl -y

# Variables
SERVER_IP=$1
WORKER_IP=$2

# Télécharger le jeton pour rejoindre le cluster
NODE_TOKEN=$(cat /vagrant/node-token)

# Installer K3s en mode agent sur le travailleur
curl -sfL https://get.k3s.io | K3S_URL="https://$SERVER_IP:6443" K3S_TOKEN="$NODE_TOKEN" INSTALL_K3S_EXEC="--node-ip $WORKER_IP" sh -

# Ajouter un alias pour 'kubectl' si besoin
echo "alias k='kubectl'" >> /etc/profile.d/00-aliases.sh
