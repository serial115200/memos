Using SSH over the HTTPS port
================================================================================

这个功能对于在受限网络环境中访问 GitHub 仓库特别有用。

参考文档：

https://docs.github.com/en/authentication/troubleshooting-ssh/using-ssh-over-the-https-port


.. code-block::

    Host github.com
        Hostname ssh.github.com
        Port 443
        User git

.. code-block::

    ~$ ssh -T -p 443 git@ssh.github.com
    Hi xxx! You've successfully authenticated, but GitHub does not provide shell access.
