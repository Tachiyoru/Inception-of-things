#!/bin/bash
set -e

while true; do
    echo "Fetching current pod for wil-service..."
    POD_NAME=$(kubectl get pods -n dev -l app=appli -o jsonpath='{.items[0].metadata.name}')
    echo "Port-forwarding to pod $POD_NAME"
    kubectl port-forward pod/$POD_NAME -n dev 8888:8888 || {
        echo "Port-forward disconnected. Retrying in 5 seconds..."
        sleep 5
    }
done
