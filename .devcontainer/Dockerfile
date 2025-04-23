FROM sphinxdoc/sphinx:8.2.3

COPY requirements.txt /

RUN <<EOF
pip install --no-cache-dir --upgrade pip
pip install --no-cache-dir -r requirements.txt
EOF
