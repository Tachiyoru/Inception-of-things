sudo k3d cluster create k3s-cluster --servers 1 --agents 2

sudo kubectl create namespace dev

sudo kubectl create namespace argocd

sudo kubectl create namespace gitlab

sudo helm repo add gitlab https://charts.gitlab.io

sudo helm repo update

sudo helm upgrade --install gitlab gitlab/gitlab --set certmanager-issuer.email=erenne@hotmail.fr \
  -n gitlab \
  -f https://gitlab.com/gitlab-org/charts/gitlab/raw/master/examples/values-minikube-minimum.yaml \
  --set global.hosts.domain=gitlab.example.com \
  --set global.hosts.https=false \
  --timeout 1000s

sudo kubectl get nodes

sudo kubectl create namespace argocd

sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

sleep 10

sudo kubectl wait pod \
    --all \
    --for=condition=Ready \
    --namespace=argocd \
    --timeout=600s \

sudo kubectl get pods -n argocd

echo "$( sudo kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode)" > ./bonus/confs/argo_passwd

sudo kubectl port-forward svc/argocd-server -n argocd 8080:443 > /dev/null 2>&1 &

sudo kubectl wait pod \
    --all \
    --for=condition=Ready \
    --namespace=argocd \
    --timeout=300s \


sudo kubectl get pods -n gitlab

sudo kubectl port-forward svc/gitlab-webservice-default -n gitlab 80:8181 > /dev/null 2>&1 &

echo "$( sudo kubectl get secret gitlab-gitlab-initial-root-password -n gitlab -o jsonpath='{.data.password}' | base64 --decode)" > ./bonus/confs/gitlab_passwd