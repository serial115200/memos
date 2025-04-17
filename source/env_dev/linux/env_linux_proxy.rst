Linux 代理配置
================================================================================


命令行代理
--------------------------------------------------------------------------------

* 键：软件使用的协议
* 值：代理使用的协议

.. code-block::
    :caption: 配置代理

    export all_proxy="socks5://127.0.0.1:1080"
    export ftp_proxy="socks5://127.0.0.1:1080"
    export http_proxy="socks5://127.0.0.1:1080"
    export https_proxy="socks5://127.0.0.1:1080"

.. code-block::
    :caption: 代理类型

    socks://       # SOCKS4
    socks4://      # SOCKS4  - 仅支持 TCP
    socks4a://     # SOCKS4a - 在代理端解析主机名
    socks5://      # SOCKS5  - 支持 TCP 和 UDP
    socks5h://     # SOCKS5  - 在代理端解析主机名
    http://        # HTTP
    https://       # HTTPS
