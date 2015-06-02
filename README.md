# Gazebo 5 docker image

This repository hold all files necessaries to build and run Gazebo 5 inside an Ubuntu 14.04 non-persistent container.

## Build Gazebo 5 image

To build the docker image run:

    $ ./build.sh

The process will last a few minutes depending your internet bandwidth.

## Run Gazebo 5

You can run an quick Gazebo 5 demo running:

    $ ./run_gazebo.sh demo

This command will load `robocup14_spl_field.world` world inside a temporary container based on `gazebo-5` image, downloading from internet models, textures and all necesaries files to run the world and storing them at `~/.gazebo` user directory for later use.

## Run shell inside image

Running the command:

    $ ./run_shell.sh

Will create a temporary container based on `gazebo-5` image and let you run commands. All files and changes outside user home directory will be lost when exits from container. Only changes within user home directory will be kept.

## Advantages of running Gazebo 5 inside container

You can install and try gazebo without installing it and its dependent packages in your real system, keeping it clean.

## TODO

* Integrate Gazebo with JdeRobot opening necesary ports.
