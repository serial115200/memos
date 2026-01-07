server certificate verification failed
================================================================================

证书验证失败，临时关闭 Git SSL 验证是最快速（但不安全）的方案。

关闭 Git SSL 验证

.. code-block:: bash

    git config --global http.sslVerify false

开启 Git SSL 验证

.. code-block:: bash

    git config --global http.sslVerify true


Linux 临时关闭 Git SSL 验证

.. code-block:: bash

    export GIT_SSL_NO_VERIFY=1

Windows 临时关闭 Git SSL 验证

.. code-block:: bash

    set GIT_SSL_NO_VERIFY 1

Windows 环境变量无法确认是临时还有永久有效
