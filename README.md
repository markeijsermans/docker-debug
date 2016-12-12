Docker Debug Container
======================

An image meant for debugging. Very often production containers are minimal in contents or even built from `scratch`. It is very tricky to diagnose issues (especially when scheduled on k8s/Mesos) without basic tools like netcat/ping/dig etc.  

This image is built from `ubuntu:16.04` and contains common networking and other system tools. See `Dockerfile` for current list of tools.

Tip:
```sh
docker run --privileged --rm -ti markeijsermans/debug
```
