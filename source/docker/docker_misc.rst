Docker 临时记录
==================================================

.. code-block::

    docker save -o <output filename> <image name>
    docker load -i <output filename at first step>

    docker save <image name> | bzip2 | ssh user@host docker load
    docker save <image name> | bzip2 | pv | ssh user@host docker load


进入容器，开启新的终端
docker exec -it id /bin/bash


进入容器，打开正在运行的终端
docker attach id


加载内核
docker run -d --privileged -v /lib/modules:/lib/modules centos:latest  bash


1. Identify the docker container id you want to access and run below command as root on host.

# docker ps
2. Get docker container’s PID:

# pid=$(docker inspect -f '{{.State.Pid}}' ${container_id})
3. Create netns directory:

# mkdir -p /var/run/netns/
4. Create the name space softlink:

# ln -sfT /proc/$pid/ns/net /var/run/netns/[container_id]
5. Run ip netns command to access this name space. For example:

# ip netns exec [container_id] ip a
