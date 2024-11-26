#!/bin/bash
NAMESPACE="dev"
SERVICE="wil-service"
LOCAL_PORT=8888
REMOTE_PORT=8888

while true; do
    POD_NAME=$(kubectl get pod -n $NAMESPACE -l app=wil-service -o jsonpath="{.items[0].metadata.name}")
    echo "Forwarding $LOCAL_PORT -> $REMOTE_PORT for pod $POD_NAME in namespace $NAMESPACE..."
    kubectl port-forward -n $NAMESPACE pod/$POD_NAME $LOCAL_PORT:$REMOTE_PORT
    echo "Port-forward disconnected. Retrying in 2 seconds..."
    sleep 2
done
