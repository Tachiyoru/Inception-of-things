#!/bin/bash

set -e

echo "Starting Kubernetes setup..."

if ! command -v curl &>/dev/null; then
  echo "Installing curl..."
  sudo apt-get update
  sudo apt-get install -y curl
fi

if ! command -v kubectl &>/dev/null; then
  echo "Installing kubectl..."
  curl -LO https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
  sudo chmod +x kubectl
  sudo mv kubectl /usr/local/bin/kubectl
  kubectl version --client
fi

if ! command -v docker &>/dev/null; then
  echo "Installing Docker..."
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  sudo usermod -aG docker "$USER"
  echo "Please log out and log back in to use Docker without sudo."
fi

if ! command -v k3d &>/dev/null; then
  echo "Installing k3d..."
  curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
  k3d --version
fi

if ! command -v helm &>/dev/null; then
  echo "Installing Helm..."
  curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
  chmod 700 get_helm.sh
  ./get_helm.sh
fi

if ! k3d cluster list | grep -q dev-cluster; then
  echo "Creating k3d cluster..."
  k3d cluster create dev-cluster
else
  echo "Cluster dev-cluster already exists."
fi

for ns in gitlab argocd dev; do
  if ! kubectl get namespace "$ns" &>/dev/null; then
    kubectl create namespace "$ns"
  else
    echo "Namespace $ns already exists."
  fi
done

helm repo add gitlab https://charts.gitlab.io
helm repo update
helm upgrade --install gitlab gitlab/gitlab \
  -n gitlab \
  -f https://gitlab.com/gitlab-org/charts/gitlab/raw/master/examples/values-minikube-minimum.yaml \
  --set global.hosts.domain=gitlab.example.com \
  --set global.hosts.https=false \
  --timeout 1000s

echo "Waiting for GitLab pods to be ready..."
kubectl wait pod --for=condition=Ready --all --namespace=gitlab --timeout=1000s


echo "Gitlab password:"
echo "$(kubectl get secret gitlab-gitlab-initial-root-password -n gitlab -o jsonpath='{.data.password}' | base64 --decode)" >gitlab_passwd
echo ""

kubectl port-forward svc/gitlab-webservice-default -n gitlab 80:81 >/dev/null 2>&1 &

sudo bash argocd.sh
