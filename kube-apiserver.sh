#!/bin/sh
# kube-apiserver.sh

. config

CRT_FILE="$CERT_DIR/kube-apiserver.crt"
KEY_FILE="$CERT_DIR/kube-apiserver.key"

exec "$KUBE_APISERVER" \
      --api-audiences=https://127.0.0.1:6443 \
      --service-account-key-file="$SA_PUB" \
      --service-account-signing-key-file="$SA_KEY" \
      --service-account-issuer=https://kubernetes.default.svc.cluster.local \
      --etcd-servers="https://localhost:2379" \
      --etcd-cafile="$CA_FILE" \
      --etcd-certfile="$CRT_FILE" \
      --etcd-keyfile="$KEY_FILE" \
      --client-ca-file="$CA_FILE" \
      --authorization-mode=RBAC \
      --tls-cert-file="$CRT_FILE" \
      --tls-private-key-file="$KEY_FILE"
