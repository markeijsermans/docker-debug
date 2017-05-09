Docker Debug Container
======================

An image meant for debugging. Includes the kitchen sink (548MB+ image). Very often production containers are minimal in contents or even built from `scratch`. It is very tricky to diagnose issues (especially when scheduled on k8s/Mesos) without basic tools like netcat/ping/dig etc.  

This image is built from `ubuntu:16.04` and contains common networking and other system tools. See `Dockerfile` for current list of tools.

### Tips
```sh
# running in privileged+host mode can be useful
docker run --privileged --net=host --rm -ti markeijsermans/debug

# start a simple http server
docker run --rm -ti -p 8000:8000 markeijsermans/debug python3 -m http.server
```

### Todo
* curl with HTTP/2 support
* remove packages that are never used
