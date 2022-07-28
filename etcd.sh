#!/bin/sh
# etcd.sh

. config

CRT_FILE="$CERT_DIR/etcd.crt"
KEY_FILE="$CERT_DIR/etcd.key"

# exec allows to avoid extra shell process existing for no reason.
exec "$ETCD" \
  --name s1 \
  --data-dir=etcd-data \
  --listen-client-urls=https://127.0.0.1:2379 \
  --advertise-client-urls=https://127.0.0.1:2379 \
  --cert-file="$CRT_FILE" \
  --key-file="$KEY_FILE" \
  --client-cert-auth \
  --trusted-ca-file="$CA_FILE"
