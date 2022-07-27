#!/bin/sh
# etcd.sh

# exec allows to avoid extra shell process existing for no reason.
exec "$ETCD" \
  --name s1 \
  --data-dir=etcd-data
