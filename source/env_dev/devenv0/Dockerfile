FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN     apt-get update \
    &&  apt-get install --no-install-recommends -y \
            sudo                                   \
            passwd                                 \
            clang                                  \
            build-essential                        \
            ccache                                 \
            cmake                                  \
            autoconf                               \
            automake                               \
            gdb                                    \
            valgrind                               \
            cpio                                   \
            gzip                                   \
            bzip2                                  \
            xz-utils                               \
            ssh                                    \
            sshpass                                \
            autossh                                \
            git                                    \
            repo                                   \
            subversion                             \
            iproute2                               \
            net-tools                              \
            iw                                     \
            wireless-tools                         \
            curl                                   \
            wget                                   \
            socat                                  \
            netcat                                 \
            libssl-dev                             \
            libnl-3-dev                            \
            libnl-genl-3-dev                       \
            libnl-route-3-dev                      \
            docker                                 \
            fakeroot                               \
            shellcheck                             \
            file                                   \
            openssl                                \
            coreutils                              \
            bsdmainutils                           \
            vim-common                             \
            lsb-release                            \
    &&  apt-get autoremove \
    &&  apt-get clean \
    &&  rm -rf /var/lib/apt/lists/*

RUN ln -sf /bin/bash /bin/sh

WORKDIR /build

CMD ["bash"]
