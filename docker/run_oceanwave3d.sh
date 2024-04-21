#!/bin/bash
# This script runs the Docker container for docker_oceanwave_final, mounting the current directory.
#
# By Allan P. Engsig-Karup, apek@dtu.dk.
#
# Example: (put the OceanWave3D.inp file in the current directory that is mounted to the docker container for it to access it)
# ./run_oceanwave3d.sh OceanWave3D.inp

# Path to the input file on the host
host_input_file="$(pwd)/$1"

# Path where the container expects the input file
container_input_path="/build/OceanWave3D.inp"

docker run -it -v "$host_input_file":"$container_input_path" docker_oceanwave_final


