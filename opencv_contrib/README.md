# opencv_contrib

This repository contains [OpenCV 3.3.1][1] dockerfile based on Ubuntu 16.04.
OpenCV 3.3.1 built with opencv_contrib module and Python bindings. The available Python versions are 2.7 and 3.5.
Built based on [Install OpenCV3 on Ubuntu][2] guide, thanks to [Vaibhaw Singh Chandel][3].

Builded image can be found at [Docker Hub][4].

## Usage
### Build image from dockerfile:
```sh
$ docker build -t svponomarev/opencv_contrib .
```
### Download image from Docker Hub:
```sh
$ docker pull svponomarev/opencv_contrib
```
### Create a new container:
```sh
$ docker run --name <CONTAINER_NAME> -it svponomarev/opencv_contrib /bin/bash
```
Detach using `Ctrl+p`+`Ctrl+q`
Exit using `Ctrl+d`
### Mount volume inside container:
```sh
$ docker run --name <CONTAINER_NAME> -it -v <YOUR_DIRECTORY>:<CONTAINER_DIRECTORY> svponomarev/opencv_contrib /bin/bash
```
### Attach to a running docker container:
```sh
$ docker attach <CONTAINER_NAME>
```
### Start an existing docker container:
```sh
$ docker start <CONTAINER_NAME>
```
### Add --rm flag for run command to remove the container after it stops:
```sh
$ docker run --rm -it svponomarev/opencv_contrib /bin/bash
```
### Compile:
```sh
$ g++ myFile.cpp `pkg-config --libs --cflags opencv` -o myProgram
```
### Test Python bindings:
Python 2.7
```sh
$ workon py2
>>> python2
>>> import cv2
>>> print cv2.__version__
3.3.1
>>> exit()
$ deactivate py2
```
Python 3.5
```sh
$ workon py3
>>> python3
>>> import cv2
>>> print (cv2.__version__)
3.3.1
>>> exit()
$ deactivate py3
```
### To display OpenCV output (e.g. imshow) via GUI from container
Give docker the rights to access the X-Server with:
```sh
$ xhost +local:docker
```
This is unsafe way, other methods are described [here][5].

Run container this way:
```sh
$ docker run -it -v /tmp/.X11-unix/:/tmp/.X11-unix -e DISPLAY=$DISPLAY svponomarev/opencv_contrib /bin/bash
```

It will work, but with some errors:
```sh
libGL error: No matching fbConfigs or visuals found
libGL error: failed to load driver: swrast
```

To fix this, install openGL drivers, e.g. for nvidia cards add to dockerfile:
```sh
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nvidia-384
```

## Authors

* **Svyatoslav Ponomarev** - sv.v.ponomarev@gmail.com


[1]: https://opencv.org/
[2]: https://www.learnopencv.com/install-opencv3-on-ubuntu/
[3]: http://home.iitk.ac.in/~vaibhaw/
[4]: https://hub.docker.com/r/svponomarev/opencv_contrib/
[5]: http://wiki.ros.org/docker/Tutorials/GUI
