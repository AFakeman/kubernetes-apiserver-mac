#!/bin/sh
# kubectl-bearer.sh

. config

SECRET=$1

shift

TOKEN=`sh kubectl.sh get secret "$SECRET" -o jsonpath='{.data.token}' | base64 -d`

exec kubectl \
    --server=https://localhost:6443 \
    --certificate-authority="$CA_FILE" \
    --token="$TOKEN" \
        "$@"
