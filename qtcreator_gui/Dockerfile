FROM ubuntu:16.04
MAINTAINER Svyatoslav Ponomarev <sv.v.ponomarev@gmail.com>

# Build is based on image zachdeiber/qt-creator, thanks to Zach Deibert
# https://github.com/zachdeibert/docker-images/tree/master/IDEs/QtCreator
# Main difference: install nvidia drivers to fix opengl errors, base image ubuntu instead of debian

# 1. Install NVIDIA drivers for OpenGL support in Qt
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nvidia-384 # one can replace version of nvidia drivers, noninteractive mode to skip keyboard configuration

# 2. Install Qt and QtCreator with dependencies
RUN apt-get update && apt-get install -y qt-sdk qtcreator

# 3. Clean temporary files
RUN apt-get autoclean && apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*