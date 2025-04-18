# syntax=docker/dockerfile:1.3-labs

ARG VARIANT=3-bullseye
FROM mcr.microsoft.com/vscode/devcontainers/python:${VARIANT}

COPY config /
COPY requirements.txt /

RUN <<EOF
apt-get update
apt-get install --no-install-recommends --yes \
     graphviz \
     imagemagick \
     make \
     git
apt-get autoremove
apt-get clean
rm -rf /var/lib/apt/lists/*
EOF

RUN <<EOF
pip install --no-cache-dir --upgrade pip
pip install --no-cache-dir -r requirements.txt
EOF
