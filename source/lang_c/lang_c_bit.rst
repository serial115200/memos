Bit
================================================================================

Does bit-shift depend on endianness?
--------------------------------------------------------------------------------
Endianness is the way values are stored in memory. When loaded into the
processor, regardless of endianness, the bit shift instruction is operating on
the value in the processor's register. Therefore, loading from memory to processor
is the equivalent of converting to big endian, the shifting operation comes next
and then the new value is stored back in memory, which is where the little endian
byte order comes into effect again.

Update, thanks to @jww: On PowerPC the vector shifts and rotates are endian
sensitive. You can have a value in a vector register and a shift will produce
different results on little-endian and big-endian.
