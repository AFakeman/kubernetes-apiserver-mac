#!/bin/env bash
# gen-certs.sh

. config

function gen_keypair() {
    local name=$1

    local key_file="$CERT_DIR/$name.key"
    local pub_file="$CERT_DIR/$name.pub"

    test -f "$key_file" || openssl genrsa -out "$key_file" 2048
    test -f "$pub_file" || openssl rsa -in "$key_file" -pubout -out "$pub_file"
}

mkdir -p "$CERT_DIR"

gen_keypair "$SA_NAME"
