#! /bin/bash

# Load image name from command line
[ -z "$1" ] && IMAGE_NAME="gazebo-5" || IMAGE_NAME="$1"

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
if [ $? -eq 0 ]
then
    echo -e "Done!\nList available images with 'docker images'"
    exit 0
else
    echo 'Build failed!'
    exit 1
fi

