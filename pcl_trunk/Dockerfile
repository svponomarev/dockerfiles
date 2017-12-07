FROM ubuntu:16.04
MAINTAINER Svyatoslav Ponomarev <sv.v.ponomarev@gmail.com>

# This dockerfile is basically just a copy of innerspace/docker-pcl: 
# https://github.com/innerspacehq/docker-pcl
# which based on https://larrylisky.com/2016/11/03/point-cloud-library-on-ubuntu-16-04-lts/
# Thanks to Matt MacGillivray

# 1. Install prerequisites (pcl)
RUN apt-get update && apt-get install -y \
software-properties-common \
git build-essential linux-libc-dev \
cmake cmake-gui \
libusb-1.0-0-dev libusb-dev libudev-dev \
mpi-default-dev openmpi-bin openmpi-common \ 
libflann1.8 libflann-dev \
libeigen3-dev \
libboost-all-dev \
libvtk5.10-qt4 libvtk5.10 libvtk5-dev \
libqhull* libgtest-dev \
freeglut3-dev pkg-config \
libxmu-dev libxi-dev \
mono-complete \
qt-sdk openjdk-8-jdk openjdk-8-jre \
openssh-client

# 2. Download pcl sources
RUN git clone https://github.com/PointCloudLibrary/pcl.git ~/pcl

# 3. Build & install pcl
RUN mkdir ~/pcl/build
RUN cd ~/pcl/build && cmake -DCMAKE_BUILD_TYPE=None -DCMAKE_INSTALL_PREFIX=/usr/local \
           -DBUILD_GPU=ON -DBUILD_apps=ON -DBUILD_examples=ON ~/pcl
RUN cd ~/pcl/build && make -j4 # substitute 4 by output of nproc
RUN cd ~/pcl/build && make -j4 install # substitute 4 by output of nproc
RUN ldconfig

# 4. Clean temporary files
RUN apt-get autoclean && apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
