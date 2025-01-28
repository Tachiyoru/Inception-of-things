#!/bin/bash
k3d cluster create dev-cluster
kubectl create namespace dev
kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sleep 10

kubectl wait pod \
  --all \
  --for=condition=Ready \
  --namespace=argocd \
  --timeout=600s

kubectl -n argocd get pods
echo "All pods are ready"

kubectl apply -n argocd -f ./p3/confs/project.yaml
kubectl apply -n argocd -f ./p3/confs/argocd.yaml

echo ""
echo "argocd password is:"
sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

echo "✅ Argo CD configuré et application déployée avec succès !"
echo ""
echo "Activating access:"
echo ""
kubectl port-forward svc/argocd-server -n argocd 8080:443
