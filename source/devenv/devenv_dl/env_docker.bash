#!/bin/bash

IMAGE="${1:-ubuntu}"

docker run  -it                                     \
            --rm                                    \
            -v "/etc/group:/etc/group:ro"           \
            -v "/etc/passwd:/etc/passwd:ro"         \
            -v "/etc/shadow:/etc/shadow:ro"         \
            --user "$(id -u):$(id -g)"              \
            --workdir="/home/$(id -un)"             \
            -v "/home/$(id -un):/home/$(id -un)"    \
            "${IMAGE}" bash
