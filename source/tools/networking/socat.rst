
socat 命令
================================================================================

项目地址: http://www.dest-unreach.org/socat/
参考文档：https://www.redhat.com/sysadmin/getting-started-socat

软件安装

.. code-block::

    sudo apt update && sudo apt install socat


socat 将两个指定的地址的数据发往对端，其中地址可以是如下形式：

* Files
* Pipes
* Devices (serial line, pseudo-terminal, etc)
* Sockets (UNIX, IP4, IP6 - raw, UDP, TCP)
* SSL sockets
* Proxy CONNECT connections
* File descriptors (stdin, etc)
* The GNU line editor (readline)
* Programs
* Combinations of two of these


使用 socat
--------------------------------------------------------------------------------

格式

.. code-block::

    socat [options] <address> <address>


有用选项

.. code-block::

    -h|-?  print a help text describing command line options and addresses
    -hh    like -h, plus a list of all common address option names
    -hhh   like -hh, plus a list of all available address option names
    -d[ddd]         increase verbosity (use up to 4 times; 2 are recommended)
    -ly[facility]  log to syslog, using facility (default is daemon)
    -lf<logfile>   log to file
    -ls            log to stderr (default if no other log)
    -v     verbose text dump of data traffic
    -x     verbose hexadecimal dump of data traffic


地址格式

.. code-block::

    [类型][地址][选项]

    类型：file tcp udp stdio ... 和运行的模式
    地址：每个类型的合法地址，如 file 是文件名，tcp 是 ip 地址和端口
    选项：接近 io 模型的选项，如 fork，reuseaddr，retry


具体格式可以查看 socat 的帮助信息，其中 - 代表 stdio，是别名，可以简化后续操作


访问 22 端口

.. code-block::

    ~$ chen@chen-VirtualBox:~$ socat -dd - tcp:127.0.0.1:22
    2024/09/14 15:27:18 socat[2004034] N reading from and writing to stdio
    2024/09/14 15:27:18 socat[2004034] N opening connection to AF=2 127.0.0.1:22
    2024/09/14 15:27:18 socat[2004034] N successfully connected from local address AF=2 127.0.0.1:50000
    2024/09/14 15:27:18 socat[2004034] N starting data transfer loop with FDs [0,1] and [5,5]
    SSH-2.0-OpenSSH_9.3p1 Ubuntu-1ubuntu3
    ^C2024/09/14 15:27:20 socat[2004034] N socat_signal(): handling signal 2
    2024/09/14 15:27:20 socat[2004034] N exiting on signal 2
    2024/09/14 15:27:20 socat[2004034] N socat_signal(): finishing signal 2
    2024/09/14 15:27:20 socat[2004034] N exit(130)

* -dd 增加 debug 信息
* - 本地地址
* tcp:127.0.0.1:22，类型是tcp，那么他的合法格式就是ip地址加端口


在 2048 端口创建可接受多个客户端的服务器，在其它终端发送数据

.. code-block::

    socat - tcp-listen:2048,fork,reuseaddr

.. code-block::

    socat - tcp:127.0.0.1:2048


将上面的 - 换成文件，可将数据写入文件

.. code-block::

    socat -U open:./tcp.log,creat,append  tcp-listen:2048,fork,reuseaddr


根据帮助信息，可得出文件的地址为 open:./tcp.log，后续为文件创建选项：新建和追加

此外，我们注意到，命令指定了方向，socat 是将两边地址的数据发往对端，如果不指定方向，那么
也会将文件的数据发到另外一端，然后因为文件数据发送完毕而关闭连接。

.. code-block::

    socat open:./tcp.log,creat,append  tcp-listen:2048,fork,reuseaddr

以上命令去除了方向，此时启动客户端就会在另外一端输出文件内容，然后断开连接。

通过以上内如不难得出以下结论：

* 对地址的理解：根据不同的情况选择地址类型，并填写地址信息和附加选项
* 对 IO 模型的理解：socat 是直接转发两端数据，文件作为地址时就要考虑文件结束的情况
* socat 本身不难，但它提供了无限的可能，只能用什么查什么


其它例子
--------------------------------------------------------------------------------

端口转发，将8080 收到的地址发到 192.168.1.3:80

.. code-block::

    socat TCP-LISTEN:8080,fork,reuseaddr  TCP:192.168.1.3:80


文件传输

.. code-block::

    socat -u TCP-LISTEN:8080 open:record.log,create    # 服务端接收文件
    socat -u open:record.log TCP:localhost:8080        # 客户端发送文件


透明代理

.. code-block::

    socat TCP-LISTEN:<本地端口>,reuseaddr,fork SOCKS:<代理服务器IP>:<远程地址>:<远程端口>,socksport=<代理服务器端口>
    socat TCP-LISTEN:<本地端口>,reuseaddr,fork PROXY:<代理服务器IP>:<远程地址>:<远程端口>,proxyport=<代理服务器端口>
