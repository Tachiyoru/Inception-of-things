#!/bin/bash

# GitLab URL
GITLAB_URL="https://127.0.0.1:81"

# Install GitLab CLI if not exists
if ! command -v glab &> /dev/null; then
  curl -L https://github.com/profclems/glab/releases/download/v1.25.4/glab_1.25.4_Linux_x86_64.tar.gz -o glab.tar.gz
  tar -xvzf glab.tar.gz
  sudo mv glab /usr/local/bin/
  rm glab.tar.gz
fi

# Create public repository using curl (GitLab API)
echo "Creating a public repository..."
curl --request POST \
  --url "${GITLAB_URL}/api/v4/projects" \
  --header "PRIVATE-TOKEN: $(cat ./scripts/gitlab_passwd)" \
  --header "Content-Type: application/json" \
  --data '{
    "name": "gitlab",
    "visibility": "public",
    "initialize_with_readme": true
  }'

# Clone the public repository
echo "Cloning the repository..."
git clone http://127.0.0.1:81/root/gitlab.git
cd gitlab

# Create initial files
echo "# My Kubernetes Project" > README.md
mkdir -p manifests
cat << EOF > manifests/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: example-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: example-app
  template:
    metadata:
      labels:
        app: example-app
    spec:
      containers:
      - name: example-app
        image: nginx:latest
EOF

# Add, commit, and push files
echo "Committing and pushing files..."
git config user.name "Root User"
git config user.email "root@example.com"
git add .
git commit -m "Initial project setup"
git push -u origin main

echo "Setup complete!"
