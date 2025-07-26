# https://chatgpt.com/c/6884d93b-6d6c-832e-b84c-163fd3fa4f58
"""
Unit tests for the Ninety-Nine problems implemented in Python.

These tests cover list processing, arithmetic functions, and logic/codes
functions up to problem P50.  Each test uses the functions defined in
`ninety_nine_problems.py` and verifies expected outputs or properties.
"""

import unittest
import math
from collections import Counter

from ninety_nine_problems import (
    my_last, my_but_last, element_at, my_count, my_reverse, palindrome,
    flatten_list, compress, pack, encode, encode_modified, decode,
    encode_direct, dupli, repli, drop_every, split, slice_, rotate,
    remove_at, insert_at, range_list, rnd_select, lotto_select, rnd_permu,
    combinations, group3, group, lsort, lfsort, is_prime, gcd, coprime,
    totient_phi, prime_factors, prime_factors_mult, phi_improved,
    nand, nor, xor, impl, equ, table, table_n, gray, huffman,
)


class TestListProblems(unittest.TestCase):
    def test_p01_my_last(self):
        self.assertEqual(my_last([1, 2, 3, 4]), 4)
        self.assertEqual(my_last([]), None)

    def test_p02_my_but_last(self):
        self.assertEqual(my_but_last([1, 2, 3, 4]), [3, 4])
        self.assertIsNone(my_but_last([1]))

    def test_p03_element_at(self):
        self.assertEqual(element_at([1, 2, 3, 4, 5], 3), 3)

    def test_p04_my_count(self):
        self.assertEqual(my_count([1, 2, 3]), 3)

    def test_p05_my_reverse(self):
        self.assertEqual(my_reverse([1, 2, 3]), [3, 2, 1])

    def test_p06_palindrome(self):
        self.assertTrue(palindrome([1, 2, 3, 2, 1]))
        self.assertFalse(palindrome([1, 2, 3]))

    def test_p07_flatten_list(self):
        self.assertEqual(flatten_list([1, [2, [3, 4], 5]]), [1, 2, 3, 4, 5])

    def test_p08_compress(self):
        self.assertEqual(compress([1, 1, 1, 2, 3, 3, 3, 2, 2]), [1, 2, 3, 2])

    def test_p09_pack(self):
        self.assertEqual(pack([1, 1, 1, 2, 3, 3, 2]), [[1, 1, 1], [2], [3, 3], [2]])

    def test_p10_encode(self):
        self.assertEqual(encode([1, 1, 1, 2, 3, 3, 2]), [(3, 1), (1, 2), (2, 3), (1, 2)])

    def test_p11_encode_modified(self):
        self.assertEqual(encode_modified([1, 1, 1, 2, 3, 3, 2]), [(3, 1), 2, (2, 3), 2])

    def test_p12_decode(self):
        data = [(4, 'a'), 'b', (2, 'c'), (2, 'a'), 'd', (4, 'e')]
        self.assertEqual(decode(data), ['a','a','a','a','b','c','c','a','a','d','e','e','e','e'])

    def test_p13_encode_direct(self):
        self.assertEqual(encode_direct([1, 1, 1, 2, 3, 3, 2]), [(3, 1), 2, (2, 3), 2])

    def test_p14_dupli(self):
        self.assertEqual(dupli([1, 2, 3]), [1, 1, 2, 2, 3, 3])

    def test_p15_repli(self):
        self.assertEqual(repli([1, 2, 3], 3), [1,1,1,2,2,2,3,3,3])

    def test_p16_drop_every(self):
        self.assertEqual(drop_every([1,2,3,4,5,6,7,8,9], 3), [1,2,4,5,7,8])

    def test_p17_split(self):
        self.assertEqual(split([1,2,3,4,5], 3), ([1,2,3], [4,5]))

    def test_p18_slice(self):
        self.assertEqual(slice_([1,2,3,4,5,6,7], 3, 6), [3,4,5,6])

    def test_p19_rotate(self):
        self.assertEqual(rotate([1,2,3,4,5,6,7], 3), [4,5,6,7,1,2,3])
        self.assertEqual(rotate([1,2,3,4,5,6], -2), [5,6,1,2,3,4])

    def test_p20_remove_at(self):
        self.assertEqual(remove_at([1,2,3,4], 2), [1,3,4])

    def test_p21_insert_at(self):
        self.assertEqual(insert_at('x', [1,2,3], 2), [1,'x',2,3])

    def test_p22_range_list(self):
        self.assertEqual(range_list(4,9), [4,5,6,7,8,9])
        self.assertEqual(range_list(9,4), [9,8,7,6,5,4])

    def test_p23_rnd_select(self):
        seq = [1,2,3,4,5,6,7,8]
        res = rnd_select(seq, 3)
        self.assertEqual(len(res), 3)
        self.assertTrue(all(x in seq for x in res))

    def test_p24_lotto_select(self):
        res = lotto_select(6, 49)
        self.assertEqual(len(res), 6)
        self.assertTrue(all(1 <= x <= 49 for x in res))

    def test_p25_rnd_permu(self):
        seq = [1,2,3,4]
        res = rnd_permu(seq)
        self.assertEqual(sorted(res), sorted(seq))

    def test_p26_combinations(self):
        combs = combinations(3, [1,2,3,4])
        self.assertEqual(len(combs), 4)
        self.assertIn([1,2,3], combs)

    def test_p27_group(self):
        res = group([1,2,3,4], [2,2])
        self.assertEqual(len(res), 3)
        for g in res:
            self.assertEqual([len(part) for part in g], [2,2])

    def test_p27_group3(self):
        res = group3([1,2,3,4,5,6,7,8,9])
        self.assertEqual(len(res), 1260)
        for a,b,c in res:
            self.assertEqual((len(a), len(b), len(c)), (2,3,4))

    def test_p28_lsort_lfsort(self):
        input_lists = [(1,2,3), (4,5), (6,7,8), (9,10), (11,12,13,14), (15,16), (17,)]
        self.assertEqual(lsort(input_lists), [[17], [4,5], [9,10], [15,16], [1,2,3], [6,7,8], [11,12,13,14]])
        lf_sorted = lfsort(input_lists)
        # frequency of lengths: {3:2,2:3,4:1,1:1}
        lengths = [len(l) for l in lf_sorted]
        # two lists should have rare lengths 4 and 1 first (in some order)
        self.assertCountEqual(lengths[:2], [4,1])
        self.assertIn(len(lf_sorted[2]), [3,2])


class TestArithmeticProblems(unittest.TestCase):
    def test_p31_is_prime(self):
        self.assertTrue(is_prime(7))
        self.assertFalse(is_prime(10))

    def test_p32_gcd(self):
        self.assertEqual(gcd(36,63), 9)

    def test_p33_coprime(self):
        """Verify the coprime function correctly detects coprime integers.

        Both (35,64) and (10,21) have greatest common divisor 1, so they are
        coprime.  The original Ninety‑Nine problem statement expects a
        return value of True in such cases.  In earlier drafts this test
        incorrectly asserted that (10,21) were not coprime; here we fix it.
        """
        self.assertTrue(coprime(35,64))
        self.assertTrue(coprime(10,21))

    def test_p34_totient_phi(self):
        self.assertEqual(totient_phi(10), 4)
        self.assertEqual(totient_phi(1), 0)

    def test_p35_prime_factors(self):
        self.assertEqual(prime_factors(315), [3,3,5,7])

    def test_p36_prime_factors_mult(self):
        self.assertEqual(prime_factors_mult(315), [(3,2),(5,1),(7,1)])

    def test_p37_phi_improved(self):
        self.assertEqual(phi_improved(10), 4)
        self.assertEqual(phi_improved(99), 60)


class TestLogicAndCodes(unittest.TestCase):
    def test_p46_logical_ops(self):
        self.assertTrue(nand(True, False))
        self.assertTrue(nand(False, True))
        self.assertFalse(nand(True, True))
        self.assertTrue(nor(False, False))
        self.assertFalse(nor(True, False))
        self.assertTrue(xor(True, False))
        self.assertFalse(xor(True, True))
        self.assertTrue(impl(False, False))
        self.assertTrue(impl(False, True))
        self.assertTrue(impl(True, True))
        self.assertFalse(impl(True, False))
        self.assertTrue(equ(True, True))
        self.assertFalse(equ(True, False))

    def test_p46_table(self):
        expr = '(and (or A B) (nand A B))'
        expected = [
            [True, True, False],
            [True, False, True],
            [False, True, True],
            [False, False, False],
        ]
        self.assertEqual(table('A', 'B', expr), expected)

    def test_p48_table_n(self):
        vars_ = ['A','B','C']
        expr = '(equ (and A (or B C)) (or (and A B) (and A C)))'
        rows = table_n(vars_, expr)
        self.assertEqual(len(rows), 8)
        # result always true
        self.assertTrue(all(row[-1] for row in rows))

    def test_p49_gray(self):
        self.assertEqual(gray(1), ["0","1"])
        self.assertEqual(gray(2), ["00","01","11","10"])
        self.assertEqual(gray(3), ["000","001","011","010","110","111","101","100"])

    def test_p50_huffman(self):
        freqs = [('a',45),('b',13),('c',12),('d',16),('e',9),('f',5)]
        codes = huffman(freqs)
        code_map = {sym: code for sym, code in codes}
        self.assertEqual(len(code_map['a']), 1)
        self.assertEqual(len(code_map['b']), 3)
        self.assertEqual(len(code_map['c']), 3)
        self.assertEqual(len(code_map['d']), 3)
        self.assertEqual(len(code_map['e']), 4)
        self.assertEqual(len(code_map['f']), 4)
        # prefix-free
        for c1 in code_map.values():
            for c2 in code_map.values():
                if c1 != c2:
                    self.assertFalse(c2.startswith(c1))


if __name__ == '__main__':
    unittest.main()