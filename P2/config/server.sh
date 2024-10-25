#!/bin/bash
sudo apt update
sudo apt install curl -y

# Variables
SERVER_IP=$1

# Installer K3s sur le serveur
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip $SERVER_IP --bind-address=$SERVER_IP --advertise-address=$SERVER_IP --write-kubeconfig-mode=644" sh -

# Attendre que K3s soit complètement installé
sleep 10
echo "Kubernetes a été installé avec succès sur le serveur"

# Ajouter un alias pour 'kubectl' pour tous les utilisateurs
echo "alias k='kubectl'" >> /etc/profile.d/00-aliases.sh

# Ajouter les noms de domaine dans le fichier hosts
echo "${SERVER_IP} app1.com" | sudo tee -a /etc/hosts
echo "${SERVER_IP} app2.com" | sudo tee -a /etc/hosts
echo "${SERVER_IP} app3.com" | sudo tee -a /etc/hosts

# Set-up des applications
cp -r /vagrant/k3s-config /tmp/k3s
kubectl apply -f /tmp/k3s/app1-deployment.yml
kubectl apply -f /tmp/k3s/app2-deployment.yml
kubectl apply -f /tmp/k3s/app3-deployment.yml
kubectl apply -f /tmp/k3s/app1-service.yml
kubectl apply -f /tmp/k3s/app2-service.yml
kubectl apply -f /tmp/k3s/app3-service.yml
kubectl apply -f /tmp/k3s/ingress.yml
