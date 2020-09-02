#!/usr/bin/env python3
# DOCS: https://dmerej.info/blog/post/chuck-norris-part-5-python-cffi/

from cffi import FFI

ffi = FFI()
ffi.cdef("""
    long blackjack(long[10], long);
""")
lib = ffi.dlopen("./libhello_nim.so")

deck = ([4]*9)
deck.append(16)

d = 0

for i in range(0, 10):

    # Dealer showing
    deck[i] -= 1
    p = 0
    for j in range(0, 10):
        deck[j] -= 1
        # NOTE: ctypes requires manually casting to c_long, whereas cffi doesn't (but requires a type signiture)
        n = lib.blackjack(deck, j+1)  #
        deck[j] += 1
        p += n
    print('Dealer showing ', i,' partitions =',p)
    d += p
    deck[i] += 1

print('Total partitions =',d)
