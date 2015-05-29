#! /bin/bash

[ -z "$2" ] && IMAGE_NAME="ub1404-dri" || IMAGE_NAME="$2"
[ -z "$1" ] && CONTAINER_NAME="ub1404-dri-c" || CONTAINER_NAME="$1"

CONTAINER_ID=$(docker ps -q --filter="name=^.?${CONTAINER_NAME}\$")
[ -n "$CONTAINER_ID" ] && echo "Stopping container '$CONTAINER_NAME'" && docker stop "$CONTAINER_ID"
CONTAINER_ID=$(docker ps -aq --filter="name=^.?${CONTAINER_NAME}\$")
[ -n "$CONTAINER_ID" ] && echo "Destroying container '$CONTAINER_NAME'" && docker rm "$CONTAINER_ID"

PARAMETERS="--privileged -e \"DISPLAY=$DISPLAY\" --name=\"$CONTAINER_NAME\" -h $CONTAINER_NAME -u redstar -w /home/redstar -i -t"

[ -c "/dev/nvidiactl" ] && PARAMETERS="$PARAMETERS --device='/dev/nvidiactl:/dev/nvidiactl:rw'"
#[ -S "/var/run/bumblebee.socket" ] && PARAMETERS="$PARAMETERS --device='/var/run/bumblebee.socket:/var/run/bumblebee.socket:rw'"
[ -d "/dev/dri" ] && PARAMETERS="$PARAMETERS -v='/dev/dri:/dev/dri:rw'"
[ -d "/tmp/.X11-unix" ] && PARAMETERS="$PARAMETERS -v='/tmp/.X11-unix:/tmp/.X11-unix:rw'"
[ -d "/var/run" ] && PARAMETERS="$PARAMETERS -v='/var/run:/var/run2:rw'"
[ -d "/dev" ] && PARAMETERS="$PARAMETERS -v='/dev:/dev2:rw'"

echo "Creating container '$CONTAINER_NAME' from image '$IMAGE_NAME'"
docker create $PARAMETERS "$IMAGE_NAME" /bin/bash && echo -e "Done!\nList containers with 'docker ps -a'" || echo 'Failed!'

