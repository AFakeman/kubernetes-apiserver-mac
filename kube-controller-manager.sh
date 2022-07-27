#!/bin/sh
# kube-controller-manager.sh

. config

exec "$KUBE_CONTROLLER_MANAGER" \
    --controllers=serviceaccount,serviceaccount-token \
    --kubeconfig kube-controller-manager.kubeconfig \
    --authentication-kubeconfig kube-controller-manager.kubeconfig \
    --authorization-kubeconfig kube-controller-manager.kubeconfig \
    --requestheader-client-ca-file="$CA_FILE" \
    --use-service-account-credentials \
    --service-account-private-key-file="$SA_KEY"
