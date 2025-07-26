// https://chatgpt.com/c/6884d93b-6d6c-832e-b84c-163fd3fa4f58
/*
 * JavaScript implementations of the first fifty Ninety‑Nine Lisp Problems.
 *
 * This module provides functions corresponding to problems P01–P28 (list
 * processing), P31–P37 (arithmetic) and P46–P50 (logic and codes).  The
 * functions mirror the behaviour of the Python solutions but are written in
 * idiomatic Node.js.  For logic problems, a simple prefix expression parser
 * and evaluator is included to handle expressions such as "(and (or A B)
 * (nand A B))".  See the accompanying Mocha test file for usage examples.
 */

// ---------------------------------------------------------------------------
// List problems

function myLast(seq) {
  // Return the last element of an array or null if empty.
  return seq.length > 0 ? seq[seq.length - 1] : null;
}

function myButLast(seq) {
  // Return an array containing the last two elements, or null if not enough.
  return seq.length >= 2 ? [seq[seq.length - 2], seq[seq.length - 1]] : null;
}

function elementAt(seq, k) {
  // Return the k‑th element (1‑indexed).
  return seq[k - 1];
}

function myCount(seq) {
  // Return the number of elements in the sequence.
  return seq.length;
}

function myReverse(seq) {
  // Return a new array with the elements reversed.
  return seq.slice().reverse();
}

function palindrome(seq) {
  // Check whether the sequence reads the same forwards and backwards.
  const arr = Array.isArray(seq) ? seq : Array.from(seq);
  for (let i = 0, j = arr.length - 1; i < j; i++, j--) {
    if (arr[i] !== arr[j]) return false;
  }
  return true;
}

function flattenList(seq) {
  // Flatten a nested array structure into a single flat array.
  const result = [];
  for (const x of seq) {
    if (Array.isArray(x)) {
      result.push(...flattenList(x));
    } else {
      result.push(x);
    }
  }
  return result;
}

function compress(seq) {
  // Eliminate consecutive duplicates from the sequence.
  const result = [];
  let prev = Symbol('sentinel');
  for (const x of seq) {
    if (x !== prev) {
      result.push(x);
      prev = x;
    }
  }
  return result;
}

function pack(seq) {
  // Pack consecutive duplicates into subarrays.
  if (seq.length === 0) return [];
  const result = [];
  let current = [seq[0]];
  for (let i = 1; i < seq.length; i++) {
    if (seq[i] === current[current.length - 1]) {
      current.push(seq[i]);
    } else {
      result.push(current);
      current = [seq[i]];
    }
  }
  result.push(current);
  return result;
}

function encode(seq) {
  // Run‑length encode the sequence using pack.
  return pack(seq).map(group => [group.length, group[0]]);
}

function encodeModified(seq) {
  // Modified run‑length encoding: singletons remain unwrapped.
  return encode(seq).map(([count, item]) => (count === 1 ? item : [count, item]));
}

function decode(seq) {
  // Decode a run‑length encoded sequence.
  const result = [];
  for (const elem of seq) {
    if (Array.isArray(elem)) {
      const [count, item] = elem;
      for (let i = 0; i < count; i++) result.push(item);
    } else {
      result.push(elem);
    }
  }
  return result;
}

function encodeDirect(seq) {
  // Direct run‑length encoding without intermediate pack.
  if (seq.length === 0) return [];
  const result = [];
  let count = 1;
  let prev = seq[0];
  for (let i = 1; i < seq.length; i++) {
    if (seq[i] === prev) {
      count++;
    } else {
      result.push(count > 1 ? [count, prev] : prev);
      prev = seq[i];
      count = 1;
    }
  }
  result.push(count > 1 ? [count, prev] : prev);
  return result;
}

function dupli(seq) {
  // Duplicate each element of the sequence.
  const result = [];
  for (const x of seq) {
    result.push(x, x);
  }
  return result;
}

function repli(seq, n) {
  // Replicate each element n times.
  const result = [];
  for (const x of seq) {
    for (let i = 0; i < n; i++) result.push(x);
  }
  return result;
}

function dropEvery(seq, n) {
  // Drop every n‑th element.
  const result = [];
  for (let i = 0; i < seq.length; i++) {
    if ((i + 1) % n !== 0) result.push(seq[i]);
  }
  return result;
}

function split(seq, n) {
  // Split the sequence at index n.
  return [seq.slice(0, n), seq.slice(n)];
}

function slice_(seq, i, k) {
  // Return a slice from i to k inclusive (1‑indexed).
  return seq.slice(i - 1, k);
}

function rotate(seq, n) {
  // Rotate the sequence left by n (negative rotates right).
  if (seq.length === 0) return [];
  const m = ((n % seq.length) + seq.length) % seq.length;
  return seq.slice(m).concat(seq.slice(0, m));
}

function removeAt(seq, k) {
  // Remove the k‑th element (1‑indexed).
  const arr = seq.slice();
  arr.splice(k - 1, 1);
  return arr;
}

function insertAt(elem, seq, k) {
  // Insert elem at position k (1‑indexed).
  const arr = seq.slice();
  arr.splice(k - 1, 0, elem);
  return arr;
}

function rangeList(start, end) {
  // Create a list of integers from start to end inclusive.
  const result = [];
  if (start <= end) {
    for (let i = start; i <= end; i++) result.push(i);
  } else {
    for (let i = start; i >= end; i--) result.push(i);
  }
  return result;
}

function rndSelect(seq, n) {
  // Randomly select n distinct elements from the sequence.
  const arr = seq.slice();
  const result = [];
  for (let i = 0; i < n && arr.length > 0; i++) {
    const idx = Math.floor(Math.random() * arr.length);
    result.push(arr.splice(idx, 1)[0]);
  }
  return result;
}

function lottoSelect(n, m) {
  // Select n different random numbers from 1..m inclusive.
  return rndSelect(rangeList(1, m), n);
}

function rndPermu(seq) {
  // Return a random permutation of the sequence.
  const arr = seq.slice();
  for (let i = arr.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [arr[i], arr[j]] = [arr[j], arr[i]];
  }
  return arr;
}

function combinations(k, seq) {
  // Generate all combinations of k distinct elements from seq.
  const res = [];
  function comb(start, combArr) {
    if (combArr.length === k) {
      res.push(combArr.slice());
      return;
    }
    for (let i = start; i < seq.length; i++) {
      comb(i + 1, combArr.concat(seq[i]));
    }
  }
  comb(0, []);
  return res;
}

function group3(seq) {
  // Group 9 elements into subsets of sizes 2, 3 and 4 (rest).
  const result = [];
  const arr = seq.slice();
  for (const a of combinations(2, arr)) {
    const rem1 = arr.filter(x => !a.includes(x));
    for (const b of combinations(3, rem1)) {
      const rem2 = rem1.filter(x => !b.includes(x));
      result.push([a.slice(), b.slice(), rem2.slice()]);
    }
  }
  return result;
}

function group(seq, sizes) {
  /* Group elements of seq into disjoint subsets of the given sizes.  The
   * order of groups does not matter; duplicate partitions where the same
   * subsets appear in a different order are removed. */
  if (sizes.length === 0) return [[]];
  const [first, ...rest] = sizes;
  const partial = [];
  for (const comb of combinations(first, seq)) {
    const remaining = seq.filter(x => !comb.includes(x));
    for (const restGroups of group(remaining, rest)) {
      partial.push([comb.slice()].concat(restGroups));
    }
  }
  // Deduplicate partitions by normalising each group of subsets.
  const seen = new Map();
  for (const grp of partial) {
    const norm = grp
      .map(sub => sub.slice().sort())
      .sort((a, b) => (a[0] < b[0] ? -1 : a[0] > b[0] ? 1 : 0));
    const key = JSON.stringify(norm);
    if (!seen.has(key)) seen.set(key, grp);
  }
  return Array.from(seen.values());
}

function lsort(seq) {
  // Sort a list of lists according to their length.
  return seq.map(s => s.slice()).sort((a, b) => a.length - b.length);
}

function lfsort(seq) {
  // Sort a list of lists according to the frequency of their lengths.
  const lengths = seq.map(s => s.length);
  const freq = lengths.reduce((acc, len) => {
    acc[len] = (acc[len] || 0) + 1;
    return acc;
  }, {});
  return seq
    .map(s => s.slice())
    .sort((a, b) => freq[a.length] - freq[b.length]);
}

// ---------------------------------------------------------------------------
// Arithmetic problems

function isPrime(n) {
  if (n <= 1) return false;
  if (n <= 3) return true;
  if (n % 2 === 0 || n % 3 === 0) return false;
  let i = 5;
  while (i * i <= n) {
    if (n % i === 0 || n % (i + 2) === 0) return false;
    i += 6;
  }
  return true;
}

function gcd(a, b) {
  // Euclid's algorithm.
  let x = Math.abs(a);
  let y = Math.abs(b);
  while (y !== 0) {
    const temp = y;
    y = x % y;
    x = temp;
  }
  return x;
}

function coprime(a, b) {
  return gcd(a, b) === 1;
}

function totientPhi(m) {
  // Naive Euler's totient.
  let count = 0;
  for (let r = 1; r < m; r++) {
    if (coprime(r, m)) count++;
  }
  return count;
}

function primeFactors(n) {
  // Return prime factors in ascending order.
  const factors = [];
  let f = 2;
  let num = n;
  while (num > 1) {
    while (num % f === 0) {
      factors.push(f);
      num = Math.floor(num / f);
    }
    f++;
  }
  return factors;
}

function primeFactorsMult(n) {
  const factors = primeFactors(n);
  const counts = {};
  for (const f of factors) counts[f] = (counts[f] || 0) + 1;
  return Object.keys(counts)
    .map(k => [parseInt(k), counts[k]])
    .sort((a, b) => a[0] - b[0]);
}

function phiImproved(m) {
  // Improved totient using prime factorisation.
  const pf = primeFactorsMult(m);
  let result = 1;
  for (const [p, k] of pf) {
    result *= Math.pow(p, k) - Math.pow(p, k - 1);
  }
  return result;
}

// ---------------------------------------------------------------------------
// Logic and Codes

function nand(a, b) {
  return !(a && b);
}

function nor(a, b) {
  return !(a || b);
}

function xor(a, b) {
  return a !== b;
}

function impl(a, b) {
  return !a || b;
}

function equ(a, b) {
  return a === b;
}

// Helper functions for parsing and evaluating prefix boolean expressions
function parsePrefix(tokens) {
  if (tokens.length === 0) throw new Error('Unexpected end of tokens');
  const token = tokens.shift();
  if (token === '(') {
    const op = tokens.shift();
    const args = [];
    while (tokens[0] !== ')') {
      args.push(parsePrefix(tokens));
      if (tokens.length === 0) throw new Error('Missing closing )');
    }
    tokens.shift();
    return [op, ...args];
  } else if (token === ')') {
    throw new Error('Unexpected )');
  } else {
    return token;
  }
}

function evalAst(ast, env) {
  if (Array.isArray(ast)) {
    const [op, ...args] = ast;
    const fn = env[op];
    if (typeof fn !== 'function') throw new Error(`Unknown operator ${op}`);
    const values = args.map(arg => evalAst(arg, env));
    return fn(...values);
  }
  // Atom
  if (ast === 'True') return true;
  if (ast === 'False') return false;
  if (ast in env) return env[ast];
  throw new Error(`Unbound symbol ${ast}`);
}

function table(var1, var2, expr) {
  /* Generate a truth table for two variables.  The expression may be a
   * function taking (a,b) or a prefix expression string.  Returns an array
   * of rows [A_value, B_value, result] in the order [true,true],
   * [true,false], [false,true], [false,false]. */
  let evaluator;
  if (typeof expr === 'function') {
    evaluator = expr;
  } else if (typeof expr === 'string') {
    const tokens = expr.replace(/\(/g, ' ( ').replace(/\)/g, ' ) ').trim().split(/\s+/);
    const ast = parsePrefix(tokens);
    evaluator = (a, b) => {
      const env = {
        [var1]: a,
        [var2]: b,
        nand: nand,
        nor: nor,
        xor: xor,
        impl: impl,
        equ: equ,
        and: (x, y) => x && y,
        or: (x, y) => x || y,
        not: x => !x,
      };
      return evalAst(ast, env);
    };
  } else {
    throw new TypeError('expr must be a function or string');
  }
  const rows = [];
  const values = [true, false];
  for (const a of values) {
    for (const b of values) {
      rows.push([a, b, evaluator(a, b)]);
    }
  }
  return rows;
}

function assignments(vars) {
  // Generate all boolean assignments for the given variable names.
  if (vars.length === 0) return [{}];
  const [first, ...rest] = vars;
  const sub = assignments(rest);
  const res = [];
  for (const assign of sub) {
    res.push(Object.assign({}, assign, { [first]: true }));
    res.push(Object.assign({}, assign, { [first]: false }));
  }
  return res;
}

function tableN(vars, expr) {
  /* Generate a truth table for multiple variables.  expr may be a function
   * taking the same number of arguments as variables, or a prefix expression
   * string.  Returns an array of rows: [val1, val2, ..., result]. */
  let evaluator;
  if (typeof expr === 'function') {
    evaluator = (...args) => expr(...args);
  } else if (typeof expr === 'string') {
    const tokens = expr.replace(/\(/g, ' ( ').replace(/\)/g, ' ) ').trim().split(/\s+/);
    const ast = parsePrefix(tokens);
    evaluator = (...args) => {
      const env = {
        nand: nand,
        nor: nor,
        xor: xor,
        impl: impl,
        equ: equ,
        and: (x, y) => x && y,
        or: (x, y) => x || y,
        not: x => !x,
      };
      for (let i = 0; i < vars.length; i++) env[vars[i]] = args[i];
      return evalAst(ast, env);
    };
  } else {
    throw new TypeError('expr must be a function or string');
  }
  const rows = [];
  for (const assign of assignments(vars)) {
    const values = vars.map(v => assign[v]);
    rows.push(values.concat([evaluator(...values)]));
  }
  return rows;
}

function gray(n) {
  if (n < 0) throw new Error('n must be non‑negative');
  if (n === 0) return [''];
  if (n === 1) return ['0', '1'];
  const prev = gray(n - 1);
  const result = [];
  for (const code of prev) result.push('0' + code);
  for (let i = prev.length - 1; i >= 0; i--) result.push('1' + prev[i]);
  return result;
}

function huffman(freqs) {
  /* Build a Huffman code from a list of [symbol, frequency] pairs.  Returns
   * an array of [symbol, code] pairs. */
  // Build initial forest of leaf nodes: each node is {symbol, freq, left, right}
  let forest = freqs.map(([sym, freq]) => ({ symbol: sym, freq: freq, left: null, right: null }));
  while (forest.length > 1) {
    // Sort nodes by frequency ascending
    forest.sort((a, b) => a.freq - b.freq);
    const [node1, node2, ...rest] = forest;
    const merged = {
      symbol: null,
      freq: node1.freq + node2.freq,
      left: node1,
      right: node2,
    };
    forest = rest.concat([merged]);
  }
  const tree = forest[0];
  const codes = {};
  const assignCodes = (node, prefix) => {
    if (!node) return;
    if (node.symbol !== null) {
      codes[node.symbol] = prefix || '0';
    } else {
      assignCodes(node.left, prefix + '0');
      assignCodes(node.right, prefix + '1');
    }
  };
  assignCodes(tree, '');
  return freqs.map(([sym]) => [sym, codes[sym]]);
}

// Export all functions
module.exports = {
  myLast,
  myButLast,
  elementAt,
  myCount,
  myReverse,
  palindrome,
  flattenList,
  compress,
  pack,
  encode,
  encodeModified,
  decode,
  encodeDirect,
  dupli,
  repli,
  dropEvery,
  split,
  slice_,
  rotate,
  removeAt,
  insertAt,
  rangeList,
  rndSelect,
  lottoSelect,
  rndPermu,
  combinations,
  group3,
  group,
  lsort,
  lfsort,
  isPrime,
  gcd,
  coprime,
  totientPhi,
  primeFactors,
  primeFactorsMult,
  phiImproved,
  nand,
  nor,
  xor,
  impl,
  equ,
  table,
  assignments,
  tableN,
  gray,
  huffman,
};