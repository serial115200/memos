Systemd 笔记
================================================================================

概述
--------------------------------------------------------------------------------

过去 Linux 使用 init 作为初始进程，然后使用以下命令启动服务。

.. code-block::

    sudo /etc/init.d/ssh start


该方案存在些许问题

* 并行启动，速度慢
* 设计简陋，只负责执行脚本，大量共用需求未实现，导致重复实现，或脚本质量参差不齐


命令篇
--------------------------------------------------------------------------------

确认版本

.. code-block::

    systemctl --version

系统命令

.. code-block::

    # 运行管理
    sudo systemctl <subcmd>

    is-system-running                   Check whether system is fully running
    default                             Enter system default mode
    rescue                              Enter system rescue mode
    emergency                           Enter system emergency mode
    halt                                Shut down and halt the system
    poweroff                            Shut down and power-off the system
    reboot                              Shut down and reboot the system
    kexec                               Shut down and reboot the system with kexec
    exit [EXIT_CODE]                    Request user instance or container exit
    switch-root ROOT [INIT]             Change to a different root file system
    suspend                             Suspend the system
    hibernate                           Hibernate the system
    hybrid-sleep                        Hibernate and suspend the system
    suspend-then-hibernate              Suspend the system, wake after a period of
                                        time, and hibernate

    # 查看启动耗时
    systemd-analyze

    # 查看每个服务的启动耗时
    systemd-analyze blame

    # 显示瀑布状的启动过程流
    systemd-analyze critical-chain

    # 显示指定服务的启动流
    systemd-analyze critical-chain atd.service

    # 主机名相关
    hostnamectl

    # 本地化设置
    localectl

    # 时区配置
    timedatectl

    # 登录用户
    loginctl

服务管理

.. code-block::

    sudo systemctl start apache.service
    sudo systemctl stop apache.service
    sudo systemctl restart apache.service
    sudo systemctl kill apache.service
    sudo systemctl reload apache.service
    sudo systemctl daemon-reload                # 重载所有修改过的配置文件
