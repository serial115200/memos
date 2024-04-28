C 语言
================================================================================


.. toctree::
   :maxdepth: 1

   lang_c_sparse
   lang_c_alignment
   lang_c_optimization


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
