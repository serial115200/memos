


.. code-block:: shell

    docker run -d --name container_name \
           --privileged \
           --cap-add=ALL  \
           -v /lib/modules:/lib/modules \
           image_id

.. code-block:: yaml

    version: "3"
    services:
    baicai_image:
        image:  debian
        container_name: "baicai_image"
        restart: unless-stopped
        command: run -c /app/config.json
        volumes:
        - ./config.json:/app/config.json
        environment:
        TZ: Asia/Shanghai
        ports:
        - "80:80"
        privileged: false
        cap_add:
        - NET_ADMIN
        - SYS_MODULE
        - SYS_PTRACE
        - SYS_ADMIN
        - NET_RAW
        cap_drop:
        - ALL
