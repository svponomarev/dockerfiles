# cv3d_dev
This repository contains a dockerfile for docker image with set of tools for 3D computer vision development: OpenCV 3.3.1 + Python {2.7, 3.5} + PCL 1.8.1 + Code::Blocks + Qt Creator built under Ubuntu 16.04.

Built image includes:
* For 2D image processing: [OpenCV][1] library with Python support and [opencv_contrib][2] module (experimental and non-free features, such as [SIFT][3], [CNN][4], etc.);
* For 3D image processing: [PCL (Point Cloud Library)][5] built from sources (for experimental features under development, like [organized edge detection][6]);
* IDE with GUI for compiling and running projects inside the container: [Code::Blocks][7] (simple projects), [Qt Creator][8] (projects with GUI and OpenGL support).

All libraries and software are built under Ubuntu 16.04.

It should be noted that Nvidia drivers was also installed in this image for correct work with OpenGL applications, so this image is suitable for systems with Nvidia graphics cards. It is possible to change dockerfile to install different drivers for graphics card on your system and rebuild the image. 

Built image can be found at [Docker Hub][9].

## Acknowledgements
OpenCV installation is based on [Install OpenCV3 on Ubuntu][10] guide, thanks to [Vaibhaw Singh Chandel][11]. PCL installation is based on [blog post][12], for dockerfile instructions thanks to Matt MacGillivray and [Innerspace][13]. Code::Blocks and Qt Creator installations are based on [Zach Deibert][14] dockerfiles with minor fixes.

## Usage
### Allow docker to access control to X server on your host:
```sh
$ xhost +local:docker
```
Warning, this is not the most safe way, other methods are described [here][15].
### Build image from dockerfile:
```sh
$ docker build -t svponomarev/cv3d_dev .
```
### Download image from Docker Hub:
```sh
$ docker pull svponomarev/cv3d_dev
```
### Create a new container with bash:
```sh
$ docker run --name <CONTAINER_NAME> -it --device /dev/nvidia0 --device /dev/nvidiactl -v /tmp:/tmp -v <YOUR_DIRECTORY>:/<DOCKER_DIRECTORY> -e DISPLAY=$DISPLAY svponomarev/cv3d_dev /bin/bash
```
### Create a new container with Code::Blocks:
```sh
$ docker run --name <CONTAINER_NAME> --device /dev/nvidia0 --device /dev/nvidiactl -v /tmp:/tmp -v <YOUR_DIRECTORY>:/<DOCKER_DIRECTORY> -e DISPLAY=$DISPLAY svponomarev/cv3d_dev codeblocks
```
### Create a new container with Qt Creator:
```sh
$ docker run --name <CONTAINER_NAME> --device /dev/nvidia0 --device /dev/nvidiactl -v /tmp:/tmp -v <YOUR_DIRECTORY>:/<DOCKER_DIRECTORY> -e DISPLAY=$DISPLAY svponomarev/cv3d_dev qtcreator
```
### Start an existing docker container:
```sh
$ docker start <CONTAINER_NAME>
```
### Add --rm flag for run command to remove the container after it stops:
```sh
$ docker run --rm --device /dev/nvidia0 --device /dev/nvidiactl -v /tmp:/tmp -v <YOUR_DIRECTORY>:/<DOCKER_DIRECTORY> -e DISPLAY=$DISPLAY svponomarev/cv3d_dev codeblocks
```
## Issues
If Code::Blocks hangs while loading projects, try to disable code completion in Plugins->Manage Plugins, as it stated [here][16].

## Authors

* **Svyatoslav Ponomarev** - sv.v.ponomarev@gmail.com

[1]: https://opencv.org/
[2]: https://github.com/opencv/opencv_contrib
[3]: https://www.pyimagesearch.com/2015/07/16/where-did-sift-and-surf-go-in-opencv-3/
[4]: https://www.pyimagesearch.com/2017/08/21/deep-learning-with-opencv/
[5]: http://pointclouds.org/
[6]: http://www.pointclouds.org/blog/gsoc12/cchoi/index.php
[7]: http://www.codeblocks.org/
[8]: https://www.qt.io/ide/
[9]: https://hub.docker.com/r/svponomarev/cv3d_dev/
[10]: https://www.learnopencv.com/install-opencv3-on-ubuntu/
[11]: http://home.iitk.ac.in/~vaibhaw/
[12]: https://larrylisky.com/2016/11/03/point-cloud-library-on-ubuntu-16-04-lts/
[13]: https://github.com/innerspacehq/docker-pcl
[14]: https://github.com/zachdeibert/docker-images/
[15]: http://wiki.ros.org/docker/Tutorials/GUI
[16]: http://sauravag.com/2016/07/fix-codeblocks-freezing-in-ubuntu/