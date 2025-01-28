#!/bin/bash

# USER TO SUDO GROUP

USERNAME=$(whoami)
su -c "bash -c 'echo \"$USERNAME ALL=(ALL) NOPASSWD:ALL\" >> /etc/sudoers'"

# VSCODE

sudo apt update

sudo apt install gnupg2 software-properties-common apt-transport-https curl

curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

sudo apt update

sudo apt install code

# VIRTUALBOX

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle_vbox_2016.gpg] http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list

wget -O- -q https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmour -o /usr/share/keyrings/oracle_vbox_2016.gpg

sudo apt update

sudo apt install virtualbox-7.0

# VAGRANT

wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && sudo apt install vagrant

# KUBECTL

sudo apt-get install ca-certificates curl

if command -v kubectl &>/dev/null; then
  echo "Kubectl installation found"
else
  curl -LO https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
  sudo chmod +x ./kubectl
  sudo mv ./kubectl /usr/local/bin/kubectl
  kubectl version --client

  sleep 10
fi

# DOCKER

if command -v docker &>/dev/null; then
  echo "Docker installation found"
else
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  rm -rf get-docker.sh
fi

sudo usermod -aG docker $USER

# K3D

if command -v k3d &>/dev/null; then
  echo "K3d installation found"
else
  curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
  k3d --version
fi

# HELM

curl https://get.helm.sh/helm-v3.10.3-linux-amd64.tar.gz -o helm.tar.gz

tar -zxvf helm.tar.gz
rm -rf helm.tar.gz

sudo mv linux-amd64/helm /usr/local/bin/helm
rm -rf linux-amd64

# SSH

ssh-keygen