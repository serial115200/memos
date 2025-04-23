FROM mcr.microsoft.com/vscode/devcontainers/python:3-bullseye

COPY requirements.txt /

RUN <<EOF
apt-get update
apt-get install --no-install-recommends --yes   \
        git \
        graphviz \
        imagemagick \
        make
apt-get autoremove
apt-get clean
rm -rf /var/lib/apt/lists/*
EOF

RUN <<EOF
pip install --no-cache-dir --upgrade pip
pip install --no-cache-dir -r requirements.txt
EOF
