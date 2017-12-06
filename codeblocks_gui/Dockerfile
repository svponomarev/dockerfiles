FROM ubuntu:16.04
MAINTAINER Svyatoslav Ponomarev <sv.v.ponomarev@gmail.com>

# Build is based on image zachdeiber/code-blocks, thanks to Zach Deibert
# https://github.com/zachdeibert/docker-images/tree/master/IDEs/CodeBlocks
# Main difference: failed to fetch https://apt.jenslody.de/stable jessie main -> choose ppa:damien-moore/codeblocks-stable instead
# Note: add-apt-repository requires ubuntu, not debian

# 1. Install dependencies
RUN apt-get update && apt-get install -y build-essential autoconf automake libtool make gcc g++ software-properties-common

# 2. Add ppa repository for codeblocks
RUN add-apt-repository ppa:damien-moore/codeblocks-stable

# 3. Install codeblocks
RUN apt-get update && apt-get install -y codeblocks codeblocks-contrib libcanberra-gtk-module

# 4. Clean temporary files
RUN apt-get autoclean && apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*