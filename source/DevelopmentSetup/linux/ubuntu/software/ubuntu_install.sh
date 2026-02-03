#!/bin/sh
# Install packages from config file(s). One package per line; # is comment.
# Usage: $0 config1.conf [config2.conf ...]

set -e
[ $# -eq 0 ] && { echo "Usage: $0 config1.conf [config2.conf ...]" >&2; exit 1; }

PACKAGES=""
for f in "$@"; do
    [ -f "$f" ] || continue
    PACKAGES="$PACKAGES $(sed -n 's/#.*//; s/\r//g; s/[[:space:]]//g; /./p' "$f")"
done

PACKAGES=$(echo $PACKAGES)
[ -z "$PACKAGES" ] && { echo "No packages from config(s)." >&2; exit 1; }

sudo apt-get update
sudo apt-get install --no-install-recommends -y $PACKAGES
