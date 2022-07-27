#!/bin/env bash
# gen-certs.sh

set -eauxo pipefail

. config

function gen_ca() {
    local name=$1
    local subj=$2

    local key_file="$CERT_DIR/$name.key"
    local crt_file="$CERT_DIR/$name.crt"

    test -f "$key_file" || openssl genrsa -out "$key_file" 2048
    test -f "$crt_file" || openssl req -x509 -new -nodes -sha256 \
        -days 1024 \
        -subj "$subj" \
        -key "$key_file" \
        -out "$crt_file"
}

function gen_crt() {
    local name=$1
    local subj=$2
    local ca=$3

    local san=

    if [ $# -ge 4 ]; then
        san=$4
    fi

    local key_file="$CERT_DIR/$name.key"
    local crt_file="$CERT_DIR/$name.crt"
    local csr_file="$CERT_DIR/$name.csr"
    local ext_file="$CERT_DIR/$name.ext"

    local ca_key_file="$CERT_DIR/$ca.key"
    local ca_crt_file="$CERT_DIR/$ca.crt"

    local extfile=

    if [ -n "$san" ]; then
        printf "subjectAltName=DNS:$san" > "$ext_file"
        extfile="-extfile $ext_file"
    fi

    test -f "$key_file" || openssl genrsa -out "$key_file" 2048

    if ! [ -f "$crt_file" ]; then
        openssl req -new -key "$key_file" -out "$csr_file" -subj "$subj"
        openssl x509 -req -sha256 \
            $extfile \
            -days 1024 \
            -CA "$ca_crt_file" \
            -CAkey "$ca_key_file" \
            -CAcreateserial \
            -in "$csr_file" \
            -out "$crt_file"
    fi

    if [ -f "$csr_file" ]; then
        rm "$csr_file"
    fi

    if [ -f "$ext_file" ]; then
        rm "$ext_file"
    fi
}

function gen_keypair() {
    local name=$1

    local key_file="$CERT_DIR/$name.key"
    local pub_file="$CERT_DIR/$name.pub"

    test -f "$key_file" || openssl genrsa -out "$key_file" 2048
    test -f "$pub_file" || openssl rsa -in "$key_file" -pubout -out "$pub_file"
}

mkdir -p "$CERT_DIR"

gen_ca "$CA_NAME" "/CN=kubernetes"
gen_crt kube-apiserver "/O=system:masters/CN=kube-apiserver" "$CA_NAME" localhost
gen_crt admin "/O=system:masters/CN=kubernetes-admin" "$CA_NAME"
gen_crt whodis "/CN=some-user" "$CA_NAME"
gen_keypair "$SA_NAME"
