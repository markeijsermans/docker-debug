Docker Debug Containers
=======================

## Kitchen Sink

`docker pull markeijsermans/debug:kitchen-sink`

An image meant for debugging. Includes the kitchen sink (548MB+ image). Very often production containers are minimal in contents or even built from `scratch`. It is very tricky to diagnose issues (especially when scheduled on k8s/Mesos) without basic tools like netcat/ping/dig etc.  

This image is built from `ubuntu:16.04` and contains common networking and other system tools. See `Dockerfile` for current list of tools. This is the default image and is tagged as `latest`.

#### Tips
```sh
# running in privileged+host mode can be useful
docker run --privileged --net=host --rm -ti markeijsermans/debug

# start a performant simple http server - only prints our "OK". Useful for load testing
docker run --rm -ti -p 8080:8080 markeijsermans/debug simple-server

# start a python http server that hosts files
docker run --rm -ti -p 8080:8080 markeijsermans/debug python3 -m http.server
```

#### Todo
* vet packages and remove those that are never used


## Bootstrap

`docker pull markeijsermans/debug:alpine`

Alpine is a great ~5MB bare-bones image. The advantage of alpine over an even more stripped image (like [distroless](https://github.com/GoogleCloudPlatform/distroless) images) is that you get a package management system.  

But, when you exec into a container to debug it's nice to have some basic tools. When you run `debug` it will add basic tools (see [bootstrap-debug/debug](bootstrap-debug/debug) for current list), add a `~/.bashrc`, and throws you into a bash sub-shell. On exit any new packages that were installed will be removed leaving the container in the original state. This approach keeps your images small, but gives you easy debug ergonomics for your most common tasks.

You can optionally specify which packages are installed. Bash is automatically installed as it is required to put you into a sub-shell:

```sh
debug vim tcpdump
```

#### Tips

Alpine has wget installed by default, so you can also run: 

```sh
wget https://git.io/vAKxa -O - | sh
```

You can include the `debug` script directly into your Dockerfile:

```dockerfile
FROM alpine
ADD https://raw.githubusercontent.com/markeijsermans/docker-debug/master/bootstrap-debug/debug /bin/debug
```

It's probably not a good idea to make this the entrypoint or cmd for an image.  
