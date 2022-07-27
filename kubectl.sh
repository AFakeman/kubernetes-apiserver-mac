#!/bin/sh
# kubectl.sh

. config

CERT_NAME=admin
CRT_FILE="$CERT_DIR/$CERT_NAME.crt"
KEY_FILE="$CERT_DIR/$CERT_NAME.key"

exec kubectl \
    --client-certificate="$CRT_FILE" \
    --client-key="$KEY_FILE" \
    --server=https://localhost:6443 \
    --certificate-authority="$CA_FILE" \
        "$@"
