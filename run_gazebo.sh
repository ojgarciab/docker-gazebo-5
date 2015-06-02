#! /bin/bash

[ -f run_common.sh ] && . run_common.sh

[ "$*" == "demo" ] && PARMS="/usr/share/gazebo-5.1/worlds/robocup14_spl_field.world" || PARMS=@*

echo "Running Gazebo 5 from image '$IMAGE_NAME'"
docker run $PARAMETERS "$IMAGE_NAME" gazebo ${PARMS[@]}

