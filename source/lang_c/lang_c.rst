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

    lang_c_lib
    lang_c_tools

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


#. 开启编译警告

.. code-block:: shell

    -Wall
    -Wextra
    -pedantic/-Wpedantic
    -Weverything (clang only)
