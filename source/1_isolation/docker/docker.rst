Dokcer
================================================================================

以下链接深入浅出，通俗易懂：

   https://yeasy.gitbook.io/docker_practice


.. toctree::
    :maxdepth: 1

    docker_command

    docker_installation
    docker_build_image

    docker_cap
    docker_alpine
    docker_heredoc
    docker_misc


https://github.com/p8952/bocker
https://zhuanlan.zhihu.com/p/441238885



# Find out pid of container
pid=$(docker inspect -f '{{.State.Pid}}' container_name)

# Add container netns to /var/run/netns so it is detected by ip netns
sudo mkdir -p /var/run/netns
sudo ln -sf /proc/$pid/ns/net "/var/run/netns/container_name"
