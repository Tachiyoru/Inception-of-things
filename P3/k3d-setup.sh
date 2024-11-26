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
# Need to apply the script of deployement

# Boucle while to wait pod ready
while [[ $(kubectl get pods -n argocd -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}' 2> /dev/null) != "True True True True True True True" ]]; \
 do echo "Waiting pods is starting..." && sleep 15; done

echo "All pods is ready"

echo "Launch the application"
kubectl apply -f ./app-config/application.yml -n argocd

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:443