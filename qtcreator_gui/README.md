# qtcreator_gui
This repository contains [Qt Creator][1] dockerfile based on Ubuntu 16.04.
Build is based on image [zachdeiber/qt-creator][2], thanks to [Zach Deibert][3].
Main difference: install nvidia drivers to fix opengl errors, base image on ubuntu instead of debian

Builded image can be found at [Docker Hub][4].

## Usage
### Allow docker to access control to X server on your host:
```sh
$ xhost +local:docker
```
Warning, this is not the most safe way, other methods are described [here][5].
### Create a new container:
```sh
$ docker run --name <CONTAINER_NAME> --device /dev/nvidia0 --device /dev/nvidiactl -e DISPLAY=$DISPLAY -v /tmp:/tmp svponomarev/qtcreator_gui qtcreator
```
### Mount volume inside container:
```sh
$ docker run --name <CONTAINER_NAME> --device /dev/nvidia0 --device /dev/nvidiactl -e DISPLAY=$DISPLAY -v <YOUR_DIRECTORY>:<CONTAINER_DIRECTORY> svponomarev/qtcreator_gui qtcreator
``` 
### Start an existing docker container:
```sh
$ docker start <CONTAINER_NAME>
```
### Add --rm flag for run command to remove the container after it stops:
```sh
$ docker run --rm --device /dev/nvidia0 --device /dev/nvidiactl -e DISPLAY=$DISPLAY -v /tmp:/tmp svponomarev/qtcreator_gui qtcreator
``` 
## Authors

* **Svyatoslav Ponomarev** - sv.v.ponomarev@gmail.com

[1]: https://www.qt.io/ide/
[2]: https://hub.docker.com/r/zachdeibert/qt-creator/
[3]: https://github.com/zachdeibert/docker-images/tree/master/IDEs/QtCreator
[4]: https://hub.docker.com/r/svponomarev/qtcreator_gui/
[5]: http://wiki.ros.org/docker/Tutorials/GUI
