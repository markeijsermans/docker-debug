# Compile simple-server
FROM golang:1.18 AS build-simple-server
WORKDIR /go/src/github.com/markeijsermans/docker-debug/kitchen-sink-debug
COPY simple-server.go go.mod go.sum ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -o simple-server .

# Prepare a layer with all required utilities
FROM ubuntu:22.04 AS template
ADD sources.list /etc/apt/sources.list
COPY packages.txt .
RUN apt-get update && \
  apt-get install $(cat packages.txt) -y && \
  apt-get clean && \
  rm packages.txt

# Compile dnsperf
FROM template AS build-dnsperf
RUN cd /tmp && \
  curl https://www.dns-oarc.net/files/dnsperf/dnsperf-2.9.0.tar.gz -O && \
  tar xf dnsperf-2.9.0.tar.gz && \
  cd dnsperf-2.9.0 && \
  ./configure && \
  make && \
  make install

# Compile wrk
FROM template AS build-wrk
RUN git clone https://github.com/wg/wrk.git /tmp/wrk && \
  cd /tmp/wrk && \
  make && \
  mv wrk /usr/local/bin/wrk

# Setup final image
FROM template AS final

# Install slow_cooker
RUN wget -O /usr/local/bin/slow_cooker https://github.com/BuoyantIO/slow_cooker/releases/download/1.2.0/slow_cooker_linux_amd64 && \
  chmod 755 /usr/local/bin/slow_cooker

# Install previously compiled binaries
COPY --from=build-dnsperf /usr/local/bin* /usr/local/bin/
COPY --from=build-simple-server /go/src/github.com/markeijsermans/docker-debug/kitchen-sink-debug/simple-server /usr/local/bin/
COPY --from=build-wrk /usr/local/bin/wrk /usr/local/bin/

# lets just set the TERM for `exec`ing into a container
ENV TERM=xterm
ADD .bashrc /root/.bashrc
MAINTAINER Mark Eijsermans <mark.eijsermans@gmail.com>
