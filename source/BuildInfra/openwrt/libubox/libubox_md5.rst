md5 模块
================================================================================

接口
--------------------------------------------------------------------------------

.. code-block:: C

    typedef struct md5_ctx {
        uint32_t lo, hi;
        uint32_t a, b, c, d;
        unsigned char buffer[64];
    } md5_ctx_t;

    extern void md5_begin(md5_ctx_t *ctx);
    extern void md5_hash(const void *data, size_t length, md5_ctx_t *ctx);
    extern void md5_end(void *resbuf, md5_ctx_t *ctx);
    int md5sum(const char *file, void *md5_buf);
