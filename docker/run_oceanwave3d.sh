#!/bin/bash
# This script runs the Docker container for docker_oceanwave_final, mounting the current directory.
#
# By Allan P. Engsig-Karup, apek@dtu.dk.
#
# Example: (put the OceanWave3D.inp file in the current directory that is mounted to the docker container for it to access it)
# ./run_oceanwave3d.sh OceanWave3D.inp

# Path to the current directory on the host
host_directory="$(pwd)"

# Path where the container expects to work
container_directory="/ocw3d"

# Path to the input file on the host
host_input_file="$(pwd)/$1"

# Path where the container expects the input file
container_input_path="/ocw3d/$1"

# Ensure the input file exists
if [ ! -f "$host_input_file" ]; then
  echo "Input file $1 does not exist in the current directory."
  exit 1
fi

# Run the Docker container, mounting both the input file and the current directory
#docker run -it -v "$host_directory":"$container_directory" docker_oceanwave_final 


#!/bin/bash
# This script runs the Docker container for docker_oceanwave_final, mounting the current directory.
#
# By Allan P. Engsig-Karup, apek@dtu.dk.
#
# Example: (put the OceanWave3D.inp file in the current directory that is mounted to the docker container for it to access it)
# ./run_oceanwave3d.sh OceanWave3D.inp
#
# Path to the input file on the host
host_input_file="$(pwd)/$1"
#host_input_file="$(pwd)/"
#
# Path where the container expects the input file
# container_input_path="/build/OceanWave3D.inp"
container_input_path="/ocw3d/OceanWave3D.inp"
#container_input_path="/build/"
#
# run bash to access image
#docker run -it --rm --entrypoint=/bin/bash -v "$host_input_file":"$container_input_path" docker_oceanwave_final

# just run oceanwave3d with input file
#docker run -it -v "$host_input_file":"$container_input_path" --mount type=bind,src="$(pwd)",target=/ocw3d docker_oceanwave_final

# mount director for output files to end up in the host directory
#docker run -it -v "$host_input_file":"$container_input_path" --mount type=bind,src="$(pwd)",target=/ocw3d docker_oceanwave_final

# enter docker image to debug
docker run -it -w /ocw3d -v "$host_input_file":"$container_input_path" --mount type=bind,src="$(pwd)",target=/ocw3d docker_oceanwave_final



# docker run -it -w /ocw3d --rm --entrypoint=/bin/bash -v "$host_input_file":"$container_input_path" --mount type=bind,src="$(pwd)",target=/ocw3d docker_oceanwave_final
