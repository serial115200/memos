# Build with: docker build --build-arg UBUNTU_VERSION=22.04 -t ubuntu-dev .
# One Dockerfile for all versions; software/ holds configs and install script.

ARG UBUNTU_VERSION=20.04
FROM ubuntu:${UBUNTU_VERSION}

ENV DEBIAN_FRONTEND=noninteractive

COPY software/ /build/software/
WORKDIR /build/software
RUN chmod +x ubuntu_install.sh && ./ubuntu_install.sh ubuntu_common.conf ubuntu_${UBUNTU_VERSION}.conf

RUN ln -sf /bin/bash /bin/sh
WORKDIR /build
CMD ["bash"]
