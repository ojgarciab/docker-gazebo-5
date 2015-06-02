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

# Generate Dockerfile from template
sed -e "s#{USER}#${USER/\#/\\\#}#g" \
    -e "s#{HOME}#${HOME/\#/\\\#}#g" \
    -e "s#{UID}#$(id -u)#g" \
    -e "s#{GID}#$(id -g)#g" \
Dockerfile.in > Dockerfile

# Build image from Dockerfile
echo "Building '$IMAGE_NAME' image"
docker build -t "$IMAGE_NAME" .

# Was image created successfully?
if [ $? -ne 0 ]
then
    echo 'Build failed!'
    exit 1
fi
  
echo -e "Done!\nList available images with 'docker images'"

