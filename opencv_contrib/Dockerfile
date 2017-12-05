FROM ubuntu:16.04
MAINTAINER Svyatoslav Ponomarev <sv.v.ponomarev@gmail.com> 

# Built using Install OpenCV3 on Ubuntu guide: 
# https://www.learnopencv.com/install-opencv3-on-ubuntu/
# Thanks to Vaibhaw Singh Chandel (http://home.iitk.ac.in/~vaibhaw/)

# 1. Install prerequisites (opencv)
RUN apt-get update && apt-get install -y \
build-essential checkinstall cmake pkg-config yasm \
git gfortran \
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

# 2. Install optional dependencies (opencv)
RUN apt-get install -y libprotobuf-dev protobuf-compiler \
libgoogle-glog-dev libgflags-dev \
libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

# 3. Install Python libraries (python 2.7 and python 3.5)
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

# 4. Download opencv and opencv_contrib sources
RUN git clone https://github.com/opencv/opencv.git ~/opencv
RUN cd ~/opencv && git checkout 3.3.1 # change to current opencv version
RUN git clone https://github.com/opencv/opencv_contrib.git ~/opencv_contrib
RUN cd ~/opencv_contrib && git checkout 3.3.1 # change to current opencv version

# 5. Build & install opencv
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

# 6. Create symlink in virtual environment for python
RUN ls ~/.virtualenvs/py2/lib/
RUN cd ~/.virtualenvs/py2/lib/python2.7/site-packages && ln -s /usr/local/lib/python2.7/dist-packages/cv2.so cv2.so
RUN cd ~/.virtualenvs/py3/lib/python3.5/site-packages && ln -s /usr/local/lib/python3.5/dist-packages/cv2.cpython-35m-x86_64-linux-gnu.so cv2.so

# 7. Update .bashrc file
RUN echo "export WORKON_HOME=~/.virtualenvs" >> ~/.bashrc
RUN echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc

# 8. Clean temporary files
RUN apt-get autoclean && apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

