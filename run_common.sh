#! /bin/bash

# Load image name from config file
CONFIG_FILE="docker-gazebo-5.conf"
if [ -f "$CONFIG_FILE" ]
then
    source "$CONFIG_FILE"
    if [ -z "$IMAGE_NAME" ]
    then
        echo "ERROR: 'IMAGE_NAME' not defined in config file '$CONFIG_FILE'"
        exit 1
    fi
else
    echo "ERROR: configuration file '$CONFIG_FILE' couldn't be read"
    exit 1
fi

PARAMETERS="--privileged --rm=true -e DISPLAY -u $USER -w $HOME -it"

# Add graphics related directories
for path in /dev /tmp/.X11-unix /run/shm "$HOME"
do
	[ -d "$path" ] && PARAMETERS="$PARAMETERS -v='$path:$path:rw'"
done
