# codeblocks_gui
This repository contains [Code::Blocks][1] dockerfile based on Ubuntu 16.04.
Build is based on image [zachdeiber/code-blocks][2], thanks to [Zach Deibert][3].
Main difference: failed to fetch https://apt.jenslody.de/stable jessie main -> choose ppa:damien-moore/codeblocks-stable

Built image can be found at [Docker Hub][4].

## Usage
### Allow docker to access control to X server on your host:
```sh
$ xhost +local:docker
```
Warning, this is not the most safe way, other methods are described [here][5].
### Build image from dockerfile:
```sh
$ docker build -t svponomarev/codeblocks_gui .
```
### Download image from Docker Hub:
```sh
$ docker pull svponomarev/codeblocks_gui
```
### Create a new container:
```sh
$ docker run --name <CONTAINER_NAME> -e DISPLAY=$DISPLAY -v /tmp:/tmp svponomarev/codeblocks_gui codeblocks
```
### Mount volume inside container:
```sh
$ docker run --name <CONTAINER_NAME> -e DISPLAY=$DISPLAY -v <YOUR_DIRECTORY>:<CONTAINER_DIRECTORY> svponomarev/codeblocks_gui codeblocks
``` 
### Start an existing docker container:
```sh
$ docker start <CONTAINER_NAME>
```
### Add --rm flag for run command to remove the container after it stops:
```sh
$ docker run --rm -e DISPLAY=$DISPLAY -v /tmp:/tmp svponomarev/codeblocks_gui codeblocks
```

## Authors

* **Svyatoslav Ponomarev** - sv.v.ponomarev@gmail.com

[1]: http://www.codeblocks.org/
[2]: https://hub.docker.com/r/zachdeibert/code-blocks/
[3]: https://github.com/zachdeibert/docker-images/tree/master/IDEs/CodeBlocks
[4]: https://hub.docker.com/r/svponomarev/codeblocks_gui/
[5]: http://wiki.ros.org/docker/Tutorials/GUI
