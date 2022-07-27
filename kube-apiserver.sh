#!/bin/sh
# kube-apiserver.sh

. config

exec "$KUBE_APISERVER" \
      --api-audiences=https://127.0.0.1:6443 \
      --service-account-key-file="$SA_PUB" \
      --service-account-signing-key-file="$SA_KEY" \
      --service-account-issuer=https://kubernetes.default.svc.cluster.local \
      --cert-dir="$CERT_DIR" \
      --etcd-servers="http://127.0.0.1:2379"
