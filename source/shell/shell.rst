Shell
================================================================================

.. toctree::
    :maxdepth: 1

    alias
    heredoc
    cmd_check

    cli_arg
    trap
    StrictMode


--------------------------------------------------------------------------------

.. code-block::

    #!/bin/bash

    # 定义 die 函数
    die() {
        echo "ERROR: $*" >&2  # 将错误信息输出到标准错误
        exit 1
    }
