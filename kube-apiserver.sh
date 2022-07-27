#!/bin/sh
# kube-apiserver.sh

CERT_DIR=certs

exec bin/kube-apiserver \
      --api-audiences=https://127.0.0.1:6443 \
      --service-account-key-file="$CERT_DIR/sa.pub" \
      --service-account-signing-key-file="$CERT_DIR/sa.key" \
      --service-account-issuer=https://kubernetes.default.svc.cluster.local \
      --cert-dir="$CERT_DIR" \
      --etcd-servers="http://127.0.0.1:2379"
