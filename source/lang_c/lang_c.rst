C 语言
================================================================================


.. toctree::
    :maxdepth: 1

    lang_c_sparse
    lang_c_alignment
    lang_c_optimization

    lang_c_bit
    lang_c_bitfield

    lang_c_union
    lang_c_hook


Clang Static Analyzer
https://cppcheck.sourceforge.io/


技巧
--------------------------------------------------------------------------------

#. 为什么自我定义: 便于条件编译

.. code-block:: C

    enum {
        SOCK_CLOEXEC = 1
    #define SOCK_CLOEXEC SOCK_CLOEXEC
    };

    #ifdef SOCK_CLOEXEC
        flags = SOCK_CLOEXEC;
    #endif


#. 格式化

vscode 环境已经集成，格式参考一下链接

https://clang.llvm.org/docs/ClangFormat.html


#. 开启编译警告

.. code-block:: shell

    -Wall
    -Wextra
    -pedantic/-Wpedantic
    -Weverything (clang only)
