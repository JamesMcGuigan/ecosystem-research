// https://chatgpt.com/c/6884d93b-6d6c-832e-b84c-163fd3fa4f58
/*
 * Unit tests for the first fifty Ninety‑Nine problems implemented in Node.js.
 *
 * These tests use the Mocha testing framework together with Node's built‑in
 * `assert` module.  To run the tests, install Mocha (e.g. `npm install
 * mocha`) and execute `npx mocha ninety_nine_problems_test.js`.  The tests
 * mirror those found in the Python version and cover list processing,
 * arithmetic, and logic/codes functions.
 */

const assert = require('assert');
const {
  myLast, myButLast, elementAt, myCount, myReverse, palindrome,
  flattenList, compress, pack, encode, encodeModified, decode,
  encodeDirect, dupli, repli, dropEvery, split, slice_, rotate,
  removeAt, insertAt, rangeList, rndSelect, lottoSelect, rndPermu,
  combinations, group3, group, lsort, lfsort, isPrime, gcd, coprime,
  totientPhi, primeFactors, primeFactorsMult, phiImproved,
  nand, nor, xor, impl, equ, table, tableN, gray, huffman,
} = require('./ninety_nine_problems');

// Helper to check prefix‑free property of Huffman codes
function isPrefixFree(codes) {
  const values = Object.values(codes);
  for (let i = 0; i < values.length; i++) {
    for (let j = 0; j < values.length; j++) {
      if (i !== j && values[j].startsWith(values[i])) return false;
    }
  }
  return true;
}

describe('List problems', function() {
  it('P01 myLast', function() {
    assert.strictEqual(myLast([1, 2, 3, 4]), 4);
    assert.strictEqual(myLast([]), null);
  });

  it('P02 myButLast', function() {
    assert.deepStrictEqual(myButLast([1, 2, 3, 4]), [3, 4]);
    assert.strictEqual(myButLast([1]), null);
  });

  it('P03 elementAt', function() {
    assert.strictEqual(elementAt([1, 2, 3, 4, 5], 3), 3);
  });

  it('P04 myCount', function() {
    assert.strictEqual(myCount([1, 2, 3]), 3);
  });

  it('P05 myReverse', function() {
    assert.deepStrictEqual(myReverse([1, 2, 3]), [3, 2, 1]);
  });

  it('P06 palindrome', function() {
    assert.strictEqual(palindrome([1, 2, 3, 2, 1]), true);
    assert.strictEqual(palindrome([1, 2, 3]), false);
  });

  it('P07 flattenList', function() {
    assert.deepStrictEqual(flattenList([1, [2, [3, 4], 5]]), [1, 2, 3, 4, 5]);
  });

  it('P08 compress', function() {
    assert.deepStrictEqual(compress([1, 1, 1, 2, 3, 3, 3, 2, 2]), [1, 2, 3, 2]);
  });

  it('P09 pack', function() {
    assert.deepStrictEqual(pack([1, 1, 1, 2, 3, 3, 2]), [[1, 1, 1], [2], [3, 3], [2]]);
  });

  it('P10 encode', function() {
    assert.deepStrictEqual(encode([1, 1, 1, 2, 3, 3, 2]), [[3, 1], [1, 2], [2, 3], [1, 2]]);
  });

  it('P11 encodeModified', function() {
    assert.deepStrictEqual(encodeModified([1, 1, 1, 2, 3, 3, 2]), [[3, 1], 2, [2, 3], 2]);
  });

  it('P12 decode', function() {
    const data = [[4, 'a'], 'b', [2, 'c'], [2, 'a'], 'd', [4, 'e']];
    assert.deepStrictEqual(
      decode(data),
      ['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a', 'a', 'd', 'e', 'e', 'e', 'e'],
    );
  });

  it('P13 encodeDirect', function() {
    assert.deepStrictEqual(encodeDirect([1, 1, 1, 2, 3, 3, 2]), [[3, 1], 2, [2, 3], 2]);
  });

  it('P14 dupli', function() {
    assert.deepStrictEqual(dupli([1, 2, 3]), [1, 1, 2, 2, 3, 3]);
  });

  it('P15 repli', function() {
    assert.deepStrictEqual(repli([1, 2, 3], 3), [1, 1, 1, 2, 2, 2, 3, 3, 3]);
  });

  it('P16 dropEvery', function() {
    assert.deepStrictEqual(dropEvery([1, 2, 3, 4, 5, 6, 7, 8, 9], 3), [1, 2, 4, 5, 7, 8]);
  });

  it('P17 split', function() {
    assert.deepStrictEqual(split([1, 2, 3, 4, 5], 3), [[1, 2, 3], [4, 5]]);
  });

  it('P18 slice_', function() {
    assert.deepStrictEqual(slice_([1, 2, 3, 4, 5, 6, 7], 3, 6), [3, 4, 5, 6]);
  });

  it('P19 rotate', function() {
    assert.deepStrictEqual(rotate([1, 2, 3, 4, 5, 6, 7], 3), [4, 5, 6, 7, 1, 2, 3]);
    assert.deepStrictEqual(rotate([1, 2, 3, 4, 5, 6], -2), [5, 6, 1, 2, 3, 4]);
  });

  it('P20 removeAt', function() {
    assert.deepStrictEqual(removeAt([1, 2, 3, 4], 2), [1, 3, 4]);
  });

  it('P21 insertAt', function() {
    assert.deepStrictEqual(insertAt('x', [1, 2, 3], 2), [1, 'x', 2, 3]);
  });

  it('P22 rangeList', function() {
    assert.deepStrictEqual(rangeList(4, 9), [4, 5, 6, 7, 8, 9]);
    assert.deepStrictEqual(rangeList(9, 4), [9, 8, 7, 6, 5, 4]);
  });

  it('P23 rndSelect', function() {
    const seq = [1, 2, 3, 4, 5, 6, 7, 8];
    const res = rndSelect(seq, 3);
    assert.strictEqual(res.length, 3);
    assert.ok(res.every(x => seq.includes(x)));
  });

  it('P24 lottoSelect', function() {
    const res = lottoSelect(6, 49);
    assert.strictEqual(res.length, 6);
    assert.ok(res.every(x => x >= 1 && x <= 49));
  });

  it('P25 rndPermu', function() {
    const seq = [1, 2, 3, 4];
    const res = rndPermu(seq);
    assert.deepStrictEqual(res.sort(), seq.sort());
  });

  it('P26 combinations', function() {
    const combs = combinations(3, [1, 2, 3, 4]);
    assert.strictEqual(combs.length, 4);
    assert.ok(combs.some(c => JSON.stringify(c) === JSON.stringify([1, 2, 3])));
  });

  it('P27 group', function() {
    const res = group([1, 2, 3, 4], [2, 2]);
    assert.strictEqual(res.length, 3);
    for (const g of res) {
      assert.deepStrictEqual(g.map(part => part.length), [2, 2]);
    }
  });

  it('P27 group3', function() {
    const res = group3([1, 2, 3, 4, 5, 6, 7, 8, 9]);
    assert.strictEqual(res.length, 1260);
    for (const [a, b, c] of res) {
      assert.deepStrictEqual([a.length, b.length, c.length], [2, 3, 4]);
    }
  });

  it('P28 lsort and lfsort', function() {
    const inputLists = [[1, 2, 3], [4, 5], [6, 7, 8], [9, 10], [11, 12, 13, 14], [15, 16], [17]];
    assert.deepStrictEqual(lsort(inputLists), [[17], [4, 5], [9, 10], [15, 16], [1, 2, 3], [6, 7, 8], [11, 12, 13, 14]]);
    const lfSorted = lfsort(inputLists);
    const lengths = lfSorted.map(l => l.length);
    // two lists should have rare lengths 4 and 1 first (in some order)
    assert.strictEqual(lengths.includes(4) && lengths.includes(1), true);
    assert.ok([3, 2].includes(lengths[2]));
  });
});

describe('Arithmetic problems', function() {
  it('P31 isPrime', function() {
    assert.strictEqual(isPrime(7), true);
    assert.strictEqual(isPrime(10), false);
  });
  it('P32 gcd', function() {
    assert.strictEqual(gcd(36, 63), 9);
  });
  it('P33 coprime', function() {
    assert.strictEqual(coprime(35, 64), true);
    assert.strictEqual(coprime(10, 21), true);
  });
  it('P34 totientPhi', function() {
    assert.strictEqual(totientPhi(10), 4);
    assert.strictEqual(totientPhi(1), 0);
  });
  it('P35 primeFactors', function() {
    assert.deepStrictEqual(primeFactors(315), [3, 3, 5, 7]);
  });
  it('P36 primeFactorsMult', function() {
    assert.deepStrictEqual(primeFactorsMult(315), [[3, 2], [5, 1], [7, 1]]);
  });
  it('P37 phiImproved', function() {
    assert.strictEqual(phiImproved(10), 4);
    assert.strictEqual(phiImproved(99), 60);
  });
});

describe('Logic and codes', function() {
  it('P46 logical operations', function() {
    assert.strictEqual(nand(true, false), true);
    assert.strictEqual(nand(false, true), true);
    assert.strictEqual(nand(true, true), false);
    assert.strictEqual(nor(false, false), true);
    assert.strictEqual(nor(true, false), false);
    assert.strictEqual(xor(true, false), true);
    assert.strictEqual(xor(true, true), false);
    assert.strictEqual(impl(false, false), true);
    assert.strictEqual(impl(false, true), true);
    assert.strictEqual(impl(true, true), true);
    assert.strictEqual(impl(true, false), false);
    assert.strictEqual(equ(true, true), true);
    assert.strictEqual(equ(true, false), false);
  });
  it('P46 table', function() {
    const expr = '(and (or A B) (nand A B))';
    const expected = [
      [true, true, false],
      [true, false, true],
      [false, true, true],
      [false, false, false],
    ];
    assert.deepStrictEqual(table('A', 'B', expr), expected);
  });
  it('P48 tableN', function() {
    const vars = ['A', 'B', 'C'];
    const expr = '(equ (and A (or B C)) (or (and A B) (and A C)))';
    const rows = tableN(vars, expr);
    assert.strictEqual(rows.length, 8);
    assert.ok(rows.every(row => row[row.length - 1]));
  });
  it('P49 gray', function() {
    assert.deepStrictEqual(gray(1), ['0', '1']);
    assert.deepStrictEqual(gray(2), ['00', '01', '11', '10']);
    assert.deepStrictEqual(gray(3), ['000', '001', '011', '010', '110', '111', '101', '100']);
  });
  it('P50 huffman', function() {
    const freqs = [['a', 45], ['b', 13], ['c', 12], ['d', 16], ['e', 9], ['f', 5]];
    const codes = huffman(freqs);
    const codeMap = {};
    for (const [sym, code] of codes) codeMap[sym] = code;
    assert.strictEqual(codeMap['a'].length, 1);
    assert.strictEqual(codeMap['b'].length, 3);
    assert.strictEqual(codeMap['c'].length, 3);
    assert.strictEqual(codeMap['d'].length, 3);
    assert.strictEqual(codeMap['e'].length, 4);
    assert.strictEqual(codeMap['f'].length, 4);
    assert.ok(isPrefixFree(codeMap));
  });
});