#!/bin/bash

set -x

echo "start deploy ${USER}"
GOOS=linux GOARCH=amd64 go build -o isucari_linux
for server in isu01; do
  ssh -t $server "sudo systemctl stop isucari.golang.service"
  scp ./isucari_linux $server:/home/isucon/isucari/webapp/go/isucari
  rsync -vau ../sql/ $server:/home/isucon/isucari/webapp/sql/
  ssh -t $server "sudo systemctl start isucari.golang.service"
done

echo "finish deploy ${USER}"
