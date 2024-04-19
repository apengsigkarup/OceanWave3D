# Use a base image with build tools installed
FROM ubuntu:20.04

# Set environment variables to avoid interaction during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary build tools and libraries
RUN apt-get update 
RUN apt-get install -y build-essential wget tar gfortran python3 git
RUN rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /build

# Copy the library files from the Dockerfile's current directory to the image
COPY Harwell.tar.gz /build/Harwell.tar.gz
COPY lapack-3.12.0.tar.gz /build/lapack-3.12.0.tar.gz
#COPY SPARSKIT2.tar.gz /build/SPARSKIT2.tar.gz
RUN git clone https://github.com/efocht/SPARSKIT2.git
RUN git clone https://github.com/apengsigkarup/OceanWave3D-Fortran90.git

# Extract the libraries
RUN tar -xzf Harwell.tar.gz \
    && tar -xzf lapack-3.12.0.tar.gz 
#    #\
#    && tar -xzf SPARSKIT2.tar.gz

# Compile Harwell (example, adjust commands as needed)
WORKDIR /build/Harwell
RUN make
RUN cp libharwell.a /usr/lib/.
# RUN cp libharwell.a 

# Compile LAPACK (adjust the version and commands as needed)
WORKDIR /build/lapack-3.12.0
RUN cp INSTALL/make.inc.gfortran make.inc
RUN make
RUN cp liblapack.a /usr/lib/.

# Compile SPARSKIT2 (adjust commands as needed)
WORKDIR /build/SPARSKIT2
RUN make all
# RUN ls -la  # This will list all files in the current directory
RUN cp libskit.a /usr/lib/.
RUN cp librefblas.a /usr/lib/libblas.a

WORKDIR /build/OceanWave3D-Fortran90
RUN ls -l /usr/lib/*.a # show list of compiled libraries
RUN make all # release
COPY docker/common.mk.docker /build/OceanWave3D-Fortran90/common.mk

# Set the final working directory
WORKDIR /build

# Command to run when starting the container
CMD ["/bin/bash"]

