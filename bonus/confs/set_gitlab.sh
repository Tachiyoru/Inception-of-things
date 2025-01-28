#!/bin/bash

# GitLab URL
GITLAB_URL="http://127.0.0.1"

# Create public repository using curl (GitLab API)
if [ ! -f ./gitlab_passwd ]; then
    echo "Error: Missing ./gitlab_passwd with GitLab token."
    exit 1
fi



Clone the public repository
echo "Cloning the repository..."
git clone "${GITLAB_URL}/root/sleon.git"
if [ $? -ne 0 ]; then
    echo "Error: Failed to clone the repository."
    exit 1
fi

cd sleon || exit

# Create initial files
echo "# My Kubernetes Project" > README.md
mkdir -p manifests


cat << EOF > deployment.yaml
---
apiVersion: v1
kind: Service
metadata:
  name: dev-service
  labels:
    app: dev
    app.kubernetes.io/instance: argocd-app
spec:
  ports:
  - port: 8888
    targetPort: 8888
    protocol: TCP
  selector:
    app: dev
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: dev-deploy
  labels:
    app: dev
spec:
  selector:
    matchLabels:
      app: dev
  template:
    metadata:
      labels:
        app: dev
    spec:
      containers:
      - name: nginx
        image: wil42/playground:v2
        ports:
        - containerPort: 8888

---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: dev-ingress
  labels:
    app: dev
  annotations:
    ingress.kubernetes.io/ssl-redirect: "false"
spec:
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: dev-service
            port:
              number: 8888
EOF


# Add, commit, and push files
git config user.name "Root User"
git config user.email "root@example.com"
git add .
git commit -m "Initial project setup"
git push -u origin main

# sudo kubectl apply -n argocd -f ./project.yaml

# sudo kubectl apply -n argocd -f ./argocd.yaml

echo "Setup complete!"