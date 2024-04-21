# Use a base image with build tools installed
FROM ubuntu:20.04 
# AS base

# Set environment variables to avoid interaction during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary build tools and libraries
RUN apt-get update 
RUN apt-get install -y build-essential wget tar gfortran python3 git
RUN rm -rf /var/lib/apt/lists/*
#RUN mkdir -p /build/OceanWave3D_devel 

# Set the working directory
WORKDIR /build

# Copy the library files from the Dockerfile's current directory to the image
COPY Harwell.tar.gz /build/Harwell.tar.gz
COPY lapack-3.12.0.tar.gz /build/lapack-3.12.0.tar.gz
#COPY SPARSKIT2.tar.gz /build/SPARSKIT2.tar.gz
RUN git clone https://github.com/efocht/SPARSKIT2.git
RUN git clone -b botp https://github.com/apengsigkarup/OceanWave3D-Fortran90.git
COPY common.mk.docker /build/. 
COPY makefile.oceanwave3d /build/. 
# OceanWave3D-Fortran90/common.mk # copy file from local dir to the docker image

# Extract the libraries
RUN tar -xzf Harwell.tar.gz \
    && tar -xzf lapack-3.12.0.tar.gz 
#    #\
#    && tar -xzf SPARSKIT2.tar.gz

# Compile Harwell (example, adjust commands as needed)
WORKDIR /build/Harwell
RUN make clean
# RUN rm libharwell.a
RUN make
RUN cp libharwell.a /usr/lib/.
RUN ranlib /usr/lib/libharwell.a
# RUN cp libharwell.a 

# Compile LAPACK (adjust the version and commands as needed)
WORKDIR /build/lapack-3.12.0
RUN cp INSTALL/make.inc.gfortran make.inc
RUN make
RUN cp liblapack.a /usr/lib/.
RUN cp librefblas.a /usr/lib/libblas.a

# Compile SPARSKIT2 (adjust commands as needed)
WORKDIR /build/SPARSKIT2
RUN make all
# RUN ls -la  # This will list all files in the current directory
RUN cp libskit.a /usr/lib/.

WORKDIR /build/OceanWave3D-Fortran90/thirdpartylibs/LIB_VTK_IO
RUN make clean
RUN make VTK_IO COMPILER=gnu
RUN cp static/*.a /usr/lib/.
RUN cp static/*.mod /build/.

WORKDIR /build/OceanWave3D-Fortran90
# RUN ls -l /usr/lib/*.a # show list of compiled libraries
RUN cp /build/common.mk.docker common.mk # copy
RUN cp /build/makefile.oceanwave3d makefile # copy

# Debugging point
# FROM base AS debug-stage
# Here insert a command to start a bash shell for interactive debugging
#RUN bash
RUN make # default
RUN make all # release

# Set the final working directory
WORKDIR /build

# Command to run when starting the container
#CMD ["/bin/bash"]
CMD ["/build/oceanwave3d"]
