# pcl_trunk

This repository contains [Point Cloud Library, PCL 1.8.1][1] unstable version (pcl-trunk) dockerfile. Built under Ubuntu 16.04, all credit for dockerfile goes to [Innerspace][2].

Builded image can be found at [Docker Hub][3].

## Usage
### Build image from dockerfile:
```sh
$ docker build -t svponomarev/pcl_trunk .
```
### Download image from Docker Hub:
```sh
$ docker pull svponomarev/pcl_trunk
```
### Create a new container:
```sh
$ docker run --name <CONTAINER_NAME> -it svponomarev/pcl_trunk /bin/bash
```
Detach using `Ctrl+p`+`Ctrl+q`
Exit using `Ctrl+d`
### Mount volume inside container:
```sh
$ docker run --name <CONTAINER_NAME> -it -v <YOUR_DIRECTORY>:<CONTAINER_DIRECTORY> svponomarev/pcl_trunk /bin/bash
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
$ docker run --rm -it svponomarev/pcl_trunk /bin/bash
```
### Compile:
Use cmake as described [here][4].

## Testing PCL library
One can use simple projects from [PCL Tutorial][5] to test builded image.

### A. Without GUI ([pcd_write][6] project):

Copy pcl_trunk/test_projects/pcd_write folder to <YOUR_DIRECTORY>
```sh
$ docker run --name <CONTAINER_NAME> -it --rm -v <YOUR_DIRECTORY>:/code svponomarev/pcl_trunk /bin/bash
/# cd /code
/# mkdir build
/# cd build
/# cmake ..
/# make
/# ./pcd_write
```
Desired output:
```sh
Saved 5 data points to test_pcd.pcd.
  0.352222 -0.151883 -0.106395
  -0.397406 -0.473106 0.292602
  -0.731898 0.667105 0.441304
  -0.734766 0.854581 -0.0361733
  -0.4607 -0.277468 -0.916762
```

### B. With GUI ([cloud_viewer][7] project):

In order to use graphical interface the following steps should be taken:
1. Install openGL drivers for your graphics card, e.g. for NVIDIA cards append to the end of the Dockerfile:
```sh
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nvidia-384
```
2. Allow docker to access control to X server on your host
```sh
$ xhost +local:docker
```
Warning, this is not the most safe way, other methods are described [here][8].

3. Add several flags to run command for docker:
```sh
--device /dev/nvidia0 --device /dev/nvidiactl -e DISPLAY=$DISPLAY
```
After this manipulations everything should work without any errors or warnings.

Therefore, to test PCL GUI application:

Copy pcl_trunk/test_projects/cloud_viewer folder to <YOUR_DIRECTORY>
```sh
$ docker run --name <CONTAINER_NAME> -it --rm --device /dev/nvidia0 --device /dev/nvidiactl -e DISPLAY=$DISPLAY -v <YOUR_DIRECTORY>:/code svponomarev/pcl_trunk /bin/bash
/# cd /code
/# mkdir build
/# cd build
/# cmake ..
/# make
/# ./cloud_viewer
```
If everything is okay, PCL viewer should pop out on the screen without any warnings.

[1]: http://pointclouds.org/
[2]: https://github.com/innerspacehq/docker-pcl
[3]: https://hub.docker.com/r/svponomarev/pcl_trunk/
[4]: http://pointclouds.org/documentation/tutorials/using_pcl_pcl_config.php#using-pcl-pcl-config
[5]: http://pointclouds.org/documentation/tutorials/
[6]: http://pointclouds.org/documentation/tutorials/writing_pcd.php#writing-pcd
[7]: http://pointclouds.org/documentation/tutorials/cloud_viewer.php#cloud-viewer
[8]: http://wiki.ros.org/docker/Tutorials/GUI
