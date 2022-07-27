#!/bin/sh
# etcd.sh

# exec allows to avoid extra shell process existing for no reason.
exec bin/etcd \
  --name s1 \
  --data-dir=etcd-data
