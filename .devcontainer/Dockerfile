FROM sphinxdoc/sphinx:8.2.3

COPY requirements.txt /requirements.txt

RUN <<EOF
apt-get update
apt-get install --no-install-recommends --yes git
apt-get autoremove
apt-get clean
rm -rf /var/lib/apt/lists/*
EOF

RUN <<EOF
pip install --no-cache-dir --upgrade pip
pip install --no-cache-dir -r /requirements.txt
EOF
