Docker 加载内核模块
================================================================================

1. Add `--cap-add SYS_MODULE` to your Docker run command to allow the container to load/unload kernel modules.
2. Bind-mount the Docker host's `/lib/modules` directory into the container. e.g. `-v /lib/modules:/lib/modules:ro`


.. code-block::

   version: 3
   services:
     nfs:
       image: erichough/nfs-server
       volumes:
         - /lib/modules:/lib/modules:ro
       cap_add:
         - SYS_ADMIN
         - SYS_MODULE
