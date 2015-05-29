#!/bin/bash

[ -z "$1" ] && CONTAINER_NAME="ub1404-dri-c" || CONTAINER_NAME="$1"

xhost si:localuser:$USER
echo "Starting container '$CONTAINER_NAME'"
docker start "$CONTAINER_NAME"

