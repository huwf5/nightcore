#!/bin/bash

# TODO:
# delete the excluded files in .dockerignore

# ./docker_image.sh nightcore
./docker_image.sh foo
./docker_image.sh bar

sudo rm -rf /mnt/inmem/nightcore
sudo mkdir -p /mnt/inmem/nightcore
sudo mkdir -p /mnt/inmem/nightcore/output /mnt/inmem/nightcore/ipc
sudo cp -r examples/c/func_config.json /mnt/inmem/nightcore/func_config.json

docker compose up
