FROM ubuntu:16.04
MAINTAINER Mark Eijsermans <mark.eijsermans@gmail.com>

ADD sources.list /etc/apt/sources.list

RUN apt-get update && \
  apt-get install -y \
    bind9utils \
    build-essential \
    bzip2 \
    coreutils \
    cpustat \
    curl \
    diffutils \
    dnsutils \
    ethtool \
    findutils \
    gcc \
    git \
    gzip \
    htop \
    ifstat \
    iftop \
    iperf \
    iproute2 \
    iptables \
    iptstate \
    iputils-ping \
    iputils-tracepath \
    jq \
    libbind-dev \
    libcap-dev \
    libgeoip-dev \
    libkrb5-dev \
    libnghttp2-dev \
    libssl-dev \
    libxml2-dev \
    lsb-release \
    lsof \
    lynx \
    make \
    net-tools \
    netcat-openbsd \
    netperf \
    nghttp2 \
    openssh-client \
    openssl \
    procps \
    socat \
    strace \
    sysstat \
    tcpdump \
    tree \
    unzip \
    vim \
    wget \
    xxdiff \
  && apt-get clean

# install slow_cooker
RUN	wget -q -O /usr/local/bin/slow_cooker https://github.com/BuoyantIO/slow_cooker/releases/download/1.1.0/slow_cooker_linux_amd64 && \
  chmod 755 /usr/local/bin/slow_cooker

# install wrk
RUN	git clone https://github.com/wg/wrk.git /tmp/wrk && \
  cd /tmp/wrk && \
  make && \
  mv wrk /usr/local/bin/wrk && \
  cd / && \
  rm -rf /tmp/wrk

# install dnsperf
RUN cd /tmp && \
  curl ftp://ftp.nominum.com/pub/nominum/dnsperf/2.1.0.0/dnsperf-src-2.1.0.0-1.tar.gz -O && \
  tar -xzf dnsperf-src-2.1.0.0-1.tar.gz && \
  cd dnsperf-src-2.1.0.0-1 && \
  ./configure && \
  make && \
  make install && \
  cd / && \
  rm -rf /tmp/dnsperf-src-2.1.0.0-1

# install curl with HTTP/2 support
RUN cd /tmp && \
  wget https://curl.haxx.se/download/curl-7.54.1.tar.bz2 && \
  tar -xjf curl-7.54.1.tar.bz2 && \
  cd curl-7.54.1 && \
  make && \
  make install && \
  ldconfig && \
  cd / && \
  rm -rf /tmp/curl-7.54.1

# add simple server
ADD simple-server /usr/local/bin/

# lets just set the TERM for `exec`ing into a container
ENV TERM=xterm
ADD .bashrc /root/.bashrc
