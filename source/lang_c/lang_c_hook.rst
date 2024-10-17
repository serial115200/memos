

内存 hook 的方法，部分也适用于任意函数
--------------------------------------------------------------------------------
GLIBC-specific solution (Removed since glibc-2.34). If your compilation
environment is glibc with gcc, you can use malloc hooks. Not only it lets you
specify custom malloc and free, but will also identify the caller by the return
address on the stack.

POSIX-specific solution. Define malloc and free as wrappers to the original
allocation routines in your executable, which will "override" the version from
libc. Inside the wrapper you can call into the original malloc implementation,
which you can look up using dlsym with RTLD_NEXT handle. Your application or
library that defines wrapper functions needs to link with -ldl.

#define _GNU_SOURCE
#include <dlfcn.h>
#include <stdio.h>

void* malloc(size_t size)
{
    void *(*libc_malloc)(size_t) = dlsym(RTLD_NEXT, "malloc");
    fprintf(stderr, "malloc(%zu)\n", size);
    return libc_malloc(size);
}

void free(void *ptr)
{
    void (*libc_free)(void*) = dlsym(RTLD_NEXT, "free");
    fprintf(stderr, "free(%p)\n", ptr);
    libc_free(ptr);
}

int main()
{
    free(malloc(10));
    return 0;
}

Linux specific. You can override functions from dynamic libraries non-invasively
by specifying them in the LD_PRELOAD environment variable.

 LD_PRELOAD=./mymalloc.so ./exe

Mac OSX specific.

Same as Linux, except you will be using DYLD_INSERT_LIBRARIES environment variable.
