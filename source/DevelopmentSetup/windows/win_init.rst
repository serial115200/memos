Windows 初始化
================================================================================

右键恢复
--------------------------------------------------------------------------------

管理员运行命令以下命令：

.. code-block::

    # win10右键
    reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
    # win11右键
    reg.exe delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /va /f
    # 重启任务管理器
    taskkill /f /im explorer.exe & start explorer.exe


软件安装
--------------------------------------------------------------------------------

- `Firefox <https://www.firefox.com/>`_
- `Chrome <https://www.google.com/chrome/>`_
- `Git <https://git-scm.com/>`_
- `TortoiseGit <https://tortoisegit.org/>`_
- `HxD <https://mh-nexus.de/en/hxd/>`_
- `Wireshark <https://www.wireshark.org/>`_
- `MobaXterm <https://mobaxterm.mobatek.net/>`_
- `Tftpd64 <https://www.tftpd64.com/>`_
- `Notepad++ <https://notepad-plus-plus.org/>`_
- `Visual Studio Code <https://code.visualstudio.com/>`_
- `VirtualBox <https://www.virtualbox.org/>`_
- `PixPin <https://pixpin.cn/>`_
- `Everything <https://www.voidtools.com/>`_
- `Foxmail <https://www.foxmail.com/>`_
- `draw.io <https://www.drawio.com/>`_
- `Bandizip <https://www.bandisoft.com/bandizip/>`_
- `WeChat <https://pc.weixin.qq.com/>`_

    - RevokeMsgPatcher
- `QQ <https://im.qq.com/>`_

软件配置
--------------------------------------------------------------------------------

Foxmail Gmail 配置

- `开启两步验证 <https://myaccount.google.com/signinoptions/twosv>`_
- `生成应用密码 <https://myaccount.google.com/apppasswords>`_
- 在 Foxmail 中添加 Gmail 账户时，选择其他邮箱，输入账号和应用密码

.. code-block::

    接收邮件服务器（IMAP）
    服务器地址：imap.gmail.com
    端口：993
    使用 SSL 加密
    发送邮件服务器（SMTP）
    服务器地址：smtp.gmail.com
    端口：465 或 587
    使用 SSL/TLS 加密
