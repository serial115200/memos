trap
================================================================================

.. code-block:: shell

    #!/bin/bash

    scratch=$(mktemp -d -t tmp.XXXXXXXXXX)

    # do somethings

    rm -rf "$scratch"


.. code-block:: shell

    #!/bin/bash
    scratch=$(mktemp -d -t tmp.XXXXXXXXXX)

    function finish {
        rm -rf "$scratch"
    }
    trap finish EXIT

    # do somethings

#. 方法二确保 finish 函数在脚本退出时必然被执行
#. 脚本错误退出，如执行错误或语法错误，可以及时清理资源
#. 脚本修改逻辑，如增删返回或退出逻辑，也可以清理资源
#. 避免了在各个返回和退出点复制粘贴清理代码，精简代码
