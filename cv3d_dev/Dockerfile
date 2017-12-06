FROM ubuntu:16.04
MAINTAINER Svyatoslav Ponomarev <sv.v.ponomarev@gmail.com>

# 1. Install prerequisites (PCL)
# PCL installation is based on https://larrylisky.com/2016/11/03/point-cloud-library-on-ubuntu-16-04-lts/
# Thanks to Matt MacGillivray and https://github.com/innerspacehq/docker-pcl

RUN apt-get update && apt-get install -y software-properties-common \
git build-essential linux-libc-dev \
cmake cmake-gui \
libusb-1.0-0-dev libusb-dev libudev-dev \
mpi-default-dev openmpi-bin openmpi-common \ 
libflann1.8 libflann-dev \
libeigen3-dev libboost-all-dev \
libvtk5.10-qt4 libvtk5.10 libvtk5-dev \
libqhull* libgtest-dev \
freeglut3-dev pkg-config \
libxmu-dev libxi-dev \
mono-complete \
qt-sdk openjdk-8-jdk openjdk-8-jre \
openssh-client

# 2. Install prerequisites (OpenCV)
# OpenCV installation is based on https://www.learnopencv.com/install-opencv3-on-ubuntu/
# Thanks to Vaibhaw Singh Chandel (http://home.iitk.ac.in/~vaibhaw/)

RUN apt-get install -y checkinstall yasm \
gfortran \
libjpeg8-dev libjasper-dev libpng12-dev \
libtiff5-dev \
libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev \
libxine2-dev libv4l-dev \
libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev \
qt5-default libgtk2.0-dev libtbb-dev \
libatlas-base-dev \
libfaac-dev libmp3lame-dev libtheora-dev \
libvorbis-dev libxvidcore-dev \
libopencore-amrnb-dev libopencore-amrwb-dev \
x264 v4l-utils
 
# 3. Install optional dependencies (OpenCV)
RUN apt-get install -y libprotobuf-dev protobuf-compiler \
libgoogle-glog-dev libgflags-dev \
libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

# 4. Install Python libraries (python 2.7 and python 3.5)
RUN apt-get install -y python-dev python-pip python3-dev python3-pip
RUN pip2 install -U pip numpy
RUN pip3 install -U pip numpy
RUN pip2 install virtualenv virtualenvwrapper
ENV WORKON_HOME ~/.virtualenvs
RUN mkdir -p $WORKON_HOME
# Create 2 virtual environments: py2 and py3
RUN /bin/bash -c "source /usr/local/bin/virtualenvwrapper.sh \
    && mkvirtualenv py2 \
    && workon py2 \
    && pip2 install numpy scipy matplotlib scikit-image scikit-learn ipython && deactivate"
RUN pip3 install virtualenv virtualenvwrapper 
RUN /bin/bash -c "source /usr/local/bin/virtualenvwrapper.sh \
    && mkvirtualenv py3 \
    && workon py3 \
    && pip3 install numpy scipy matplotlib scikit-image scikit-learn ipython && deactivate" 

# 5. Download opencv and opencv_contrib sources
RUN git clone https://github.com/opencv/opencv.git ~/opencv
RUN cd ~/opencv && git checkout 3.3.1 # change to current opencv version
RUN git clone https://github.com/opencv/opencv_contrib.git ~/opencv_contrib
RUN cd ~/opencv_contrib && git checkout 3.3.1 # change to current opencv version

# 6. Build & install OpenCV
RUN mkdir ~/opencv/build
RUN cd ~/opencv/build && cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D INSTALL_C_EXAMPLES=ON \
      -D INSTALL_PYTHON_EXAMPLES=ON \
      -D WITH_TBB=ON \
      -D WITH_V4L=ON \
      -D WITH_QT=ON \
      -D WITH_OPENGL=ON \
      -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
      -D BUILD_EXAMPLES=ON ~/opencv
RUN cd ~/opencv/build && make -j4 # substitute 4 by output of nproc
RUN cd ~/opencv/build && make -j4 install # substitute 4 by output of nproc
RUN sh -c 'echo "/usr/lib" >> /etc/ld.so.conf.d/opencv.conf'
RUN ldconfig 

# 7. Create symlink in virtual environment for python
RUN ls ~/.virtualenvs/py2/lib/
RUN cd ~/.virtualenvs/py2/lib/python2.7/site-packages && ln -s /usr/local/lib/python2.7/dist-packages/cv2.so cv2.so
RUN cd ~/.virtualenvs/py3/lib/python3.5/site-packages && ln -s /usr/local/lib/python3.5/dist-packages/cv2.cpython-35m-x86_64-linux-gnu.so cv2.so

# 8. Update .bashrc file
RUN echo "export WORKON_HOME=~/.virtualenvs" >> ~/.bashrc
RUN echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc

# 9. Download PCL sources 
RUN git clone https://github.com/PointCloudLibrary/pcl.git ~/pcl

# 10. Build & install PCL
RUN mkdir ~/pcl/build
RUN cd ~/pcl/build && cmake -DCMAKE_BUILD_TYPE=None -DCMAKE_INSTALL_PREFIX=/usr \
           -DBUILD_GPU=ON -DBUILD_apps=ON -DBUILD_examples=ON \
-DCMAKE_INSTALL_PREFIX=/usr ~/pcl
RUN cd ~/pcl/build && make -j4 # substitute 4 by output of nproc
RUN cd ~/pcl/build && make -j4 install # substitute 4 by output of nproc
RUN ldconfig

# 11. Add ppa repository for Codeblocks
## Codeblocks installation is based on image zachdeiber/code-blocks, thanks to Zach Deibert
# https://github.com/zachdeibert/docker-images/tree/master/IDEs/CodeBlocks
# Main difference: failed to fetch https://apt.jenslody.de/stable jessie main -> choose ppa:damien-moore/codeblocks-stable instead
# Note: add-apt-repository requires ubuntu, not debian
RUN add-apt-repository ppa:damien-moore/codeblocks-stable

# 12. Install Codeblocks
RUN apt-get update && apt-get install -y codeblocks codeblocks-contrib libcanberra-gtk-module   

# 13. Install NVIDIA drivers for OpenGL support in Qt
# Qt installation is based on image zachdeiber/qt-creator, thanks to Zach Deibert
# https://github.com/zachdeibert/docker-images/tree/master/IDEs/QtCreator
# Main difference: install nvidia drivers to fix opengl errors, base image ubuntu instead of debian
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nvidia-384

# 14. Install additional OpenGL libraries
RUN apt-get install -y libglfw3-dev libglew-dev
RUN ldconfig

# 15. Clean temporary files
RUN apt-get autoclean && apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 
