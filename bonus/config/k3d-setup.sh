#!/bin/bash

echo "###################### Creation Cluster ######################"
#  Create the cluster
k3d cluster create argocd

echo "###################### Creation Namespace ######################"
# Create both namespace
kubectl create namespace dev
kubectl create namespace argocd

echo "###################### Install ArgoCD ######################"
# Install argocd on pods
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.3.5/manifests/install.yaml

echo "###################### Deploy script ######################"

# Boucle while to wait pod ready
while [[ $(kubectl get pods -n argocd -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}' 2> /dev/null) != "True True True True True True True" ]]; \
 do echo "Waiting pods is starting..." && sleep 15; done
# sleep 200
echo "All pods is ready"

echo "Launch the application"
cp -r /vagrant/app-config /tmp/app
kubectl apply -f /tmp/app/application.yml -n argocd

echo -n "User : admin Password : "

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo