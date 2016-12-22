FROM ubuntu:16.04
MAINTAINER Mark Eijsermans <mark.eijsermans@gmail.com>

ADD sources.list /etc/apt/sources.list

RUN apt-get update && \
	apt-get install -y \
		bzip2 \
    coreutils \
    cpustat \
    curl \
    diffutils \
    dnsutils \
    ethtool \
    findutils \
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
    lsb-release \
    lsof \
    lynx \
    net-tools \
    netcat-openbsd \
    netperf \
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
    xxdiff && \
  apt-get clean

# lets just set the TERM for `exec`ing into a container
ENV TERM=xterm
ADD .bashrc /root/.bashrc
