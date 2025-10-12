Strict Mode
================================================================================

.. code-block:: shell

    #!/bin/bash
    set -euo pipefail
    IFS=$'\n\t'

.. code-block:: shell

    #!/bin/bash
    set -e
    set -u
    set -o pipefail
    IFS=$'\n\t'

上面两者等价，作用如下：

#. set -e 指示 bash 在任何命令具有非零退出状态时立即退出。
#. set -u 指示 bash 在引用任何未定义变量（$* 和 $@ 除外）时都会出错，并立即退出。
#. set -o pipefail 管道中任何失败的命令退出码成为整个管道的退出码
