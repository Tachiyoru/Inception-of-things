#!/bin/bash

echo "###################### Install Helm ######################"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

echo "###################### Install Gitlab ######################"
kubectl create namespace gitlab
helm repo add gitlab https://charts.gitlab.io/

helm repo update
helm upgrade --install gitlab gitlab/gitlab \
  --timeout 600s \
  --set global.hosts.domain=gitlab.sleon.com \
  --set certmanager-issuer.email=sleon@student.42.fr \
  --set global.hosts.https=false\
  --set global.ingress.configureCertmanager=false\
  --set gitlab-runner.install="false" -n gitlab

echo "###################### Wait for Gitlab ######################"
kubectl wait -n gitlab --for=condition=available deployment --all --timeout=-1s

echo -n "User : root Password : "
kubectl get secret -n gitlab gitlab-gitlab-initial-root-password -o jsonpath='{.data.password}' | base64 -d; echo

kubectl port-forward --address 0.0.0.0 svc/gitlab-webservice-default -n gitlab 8085:8181 | kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:443 

echo "###################### Done ######################"