#!/bin/bash

# k3d cluster create mycluster --api-port 0.0.0.0:8080 --kubeconfig-update-default --kubeconfig-switch-context 
k3d cluster create mycluster --kubeconfig-update-default --kubeconfig-switch-context 
k3d kubeconfig merge mycluster --kubeconfig-switch-context

kubectl create namespace dev
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# cp -r /vagrant/k3s-config /tmp/k3s
# kubectl apply -f /tmp/k3s/ingress.yaml

# kubectl wait --for=condition=Ready -n argocd --all --timeout=15s


# kubectl port-forward svc/argocd-server -n argocd 8080:443
# argocd-server --insecure false