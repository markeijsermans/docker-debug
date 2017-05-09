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
    lsb-release \
    lsof \
    lynx \
		make \
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

# lets just set the TERM for `exec`ing into a container
ENV TERM=xterm
ADD .bashrc /root/.bashrc
