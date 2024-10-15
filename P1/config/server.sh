#!/bin/bash
sudo apt update
sudo apt install curl -y
sudo apt install net-tools

# Variables
SERVER_IP=$1

# Installer K3s sur le serveur
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip $SERVER_IP --bind-address=$SERVER_IP --advertise-address=$SERVER_IP --write-kubeconfig-mode=644" sh -

# Attendre que K3s soit complètement installé
sleep 10

# Copier le token pour que les travailleurs puissent se joindre
sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/node-token

# Copier la configuration kubeconfig dans le répertoire partagé
sudo cp /etc/rancher/k3s/k3s.yaml /vagrant/kubeconfig.yaml

# Ajouter un alias pour 'kubectl' pour tous les utilisateurs
echo "alias k='kubectl'" >> /etc/profile.d/00-aliases.sh
