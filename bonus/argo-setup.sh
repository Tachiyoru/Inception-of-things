# Login to ArgoCD
argocd login localhost:8080 --username admin --password $(cat ./scripts/argocd_passwd)

# Add GitLab repository
argocd repo add http://127.0.0.1:81/root/gitlab.git \
  --username root \
  --password $(cat ./scripts/gitlab_passwd) \

# Create ArgoCD project
kubectl apply -f ./confs/argocd/project.yaml

# Create ArgoCD application
kubectl apply -f ./confs/argocd/argocd.yaml