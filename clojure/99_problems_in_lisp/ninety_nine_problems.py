# https://chatgpt.com/c/6884d93b-6d6c-832e-b84c-163fd3fa4f58
"""
Python implementations for a subset of the classic Ninety‑Nine Lisp Problems.

This module defines functions corresponding to many of the problems from the
University of Campinas list【970221147506275†L6-L20】【970221147506275†L26-L46】.  The focus here is on
list processing (P01–P28), arithmetic (P31–P37) and logic/codes (P46–P50).

Each problem is implemented in a straightforward, Pythonic way.  See the
accompanying `ninety_nine_problems_test.py` for unit tests verifying
correctness.  Problems beyond P50 are not implemented in this module.
"""

from __future__ import annotations

import math
import random
import itertools
from collections import Counter
from typing import Any, Iterable, List, Sequence, Tuple, Dict


# -----------------------------------------------------------------------------
# List problems

def my_last(seq: Sequence[Any]) -> Any | None:
    """Return the last element of a sequence or None if empty."""
    return seq[-1] if seq else None


def my_but_last(seq: Sequence[Any]) -> List[Any] | None:
    """Return a list containing the last two elements of the sequence."""
    if len(seq) < 2:
        return None
    return [seq[-2], seq[-1]]


def element_at(seq: Sequence[Any], k: int) -> Any:
    """Return the Kth element of seq (1-indexed)."""
    return seq[k - 1]


def my_count(seq: Sequence[Any]) -> int:
    """Return the number of elements in seq."""
    return sum(1 for _ in seq)


def my_reverse(seq: Sequence[Any]) -> List[Any]:
    """Return a new list with the elements of seq in reverse order."""
    return list(reversed(seq))


def palindrome(seq: Sequence[Any]) -> bool:
    """Return True if seq is a palindrome."""
    s = list(seq)
    return s == s[::-1]


def flatten_list(seq: Iterable[Any]) -> List[Any]:
    """Flatten a nested list structure into a single flat list."""
    result: List[Any] = []
    for x in seq:
        if isinstance(x, (list, tuple)):
            result.extend(flatten_list(x))
        else:
            result.append(x)
    return result


def compress(seq: Sequence[Any]) -> List[Any]:
    """Eliminate consecutive duplicates from seq."""
    result: List[Any] = []
    prev = object()
    for x in seq:
        if x != prev:
            result.append(x)
            prev = x
    return result


def pack(seq: Sequence[Any]) -> List[List[Any]]:
    """Pack consecutive duplicates into sublists."""
    if not seq:
        return []
    result: List[List[Any]] = []
    current: List[Any] = [seq[0]]
    for x in seq[1:]:
        if x == current[-1]:
            current.append(x)
        else:
            result.append(current)
            current = [x]
    result.append(current)
    return result


def encode(seq: Sequence[Any]) -> List[Tuple[int, Any]]:
    """Run-length encode seq using pack."""
    return [(len(group), group[0]) for group in pack(seq)]


def encode_modified(seq: Sequence[Any]) -> List[Any]:
    """Modified run-length encoding: singletons are copied as is."""
    result: List[Any] = []
    for count, item in encode(seq):
        if count == 1:
            result.append(item)
        else:
            result.append((count, item))
    return result


def decode(seq: Sequence[Any]) -> List[Any]:
    """Decode a run-length encoded sequence."""
    result: List[Any] = []
    for elem in seq:
        if isinstance(elem, tuple):
            count, item = elem
            result.extend([item] * count)
        else:
            result.append(elem)
    return result


def encode_direct(seq: Sequence[Any]) -> List[Any]:
    """Direct run-length encoding without creating intermediate lists."""
    if not seq:
        return []
    result: List[Any] = []
    count = 1
    prev = seq[0]
    for x in seq[1:]:
        if x == prev:
            count += 1
        else:
            result.append((count, prev) if count > 1 else prev)
            prev = x
            count = 1
    result.append((count, prev) if count > 1 else prev)
    return result


def dupli(seq: Sequence[Any]) -> List[Any]:
    """Duplicate each element of seq."""
    result: List[Any] = []
    for x in seq:
        result.extend([x, x])
    return result


def repli(seq: Sequence[Any], n: int) -> List[Any]:
    """Replicate each element of seq n times."""
    result: List[Any] = []
    for x in seq:
        result.extend([x] * n)
    return result


def drop_every(seq: Sequence[Any], n: int) -> List[Any]:
    """Drop every n-th element from seq."""
    result: List[Any] = []
    for idx, x in enumerate(seq, start=1):
        if idx % n != 0:
            result.append(x)
    return result


def split(seq: Sequence[Any], n: int) -> Tuple[List[Any], List[Any]]:
    """Split seq into two parts; the first part has n elements."""
    return (list(seq[:n]), list(seq[n:]))


def slice_(seq: Sequence[Any], i: int, k: int) -> List[Any]:
    """Return a slice from the ith to the kth element (inclusive, 1-indexed)."""
    return list(seq[i - 1 : k])


def rotate(seq: Sequence[Any], n: int) -> List[Any]:
    """Rotate seq n places to the left (negative rotates right)."""
    n = n % len(seq) if seq else 0
    return list(seq[n:] + seq[:n])


def remove_at(seq: Sequence[Any], k: int) -> List[Any]:
    """Remove the k-th element from seq (1-indexed)."""
    return list(seq[: k - 1] + seq[k:])


def insert_at(elem: Any, seq: Sequence[Any], k: int) -> List[Any]:
    """Insert elem at position k in seq (1-indexed)."""
    return list(seq[: k - 1] + [elem] + seq[k - 1 :])


def range_list(start: int, end: int) -> List[int]:
    """Create a list containing all integers from start to end inclusive."""
    step = 1 if start <= end else -1
    return list(range(start, end + step, step))


def rnd_select(seq: Sequence[Any], n: int) -> List[Any]:
    """Return a list of n randomly selected elements from seq."""
    return random.sample(list(seq), n)


def lotto_select(n: int, m: int) -> List[int]:
    """Return n different random numbers selected from 1..m."""
    return rnd_select(range_list(1, m), n)


def rnd_permu(seq: Sequence[Any]) -> List[Any]:
    """Return a random permutation of seq."""
    lst = list(seq)
    random.shuffle(lst)
    return lst


def combinations(k: int, seq: Sequence[Any]) -> List[List[Any]]:
    """Generate all combinations of k distinct elements chosen from seq."""
    return [list(comb) for comb in itertools.combinations(seq, k)]


def group3(seq: Sequence[Any]) -> List[List[List[Any]]]:
    """Group elements of seq into subsets of sizes 2, 3 and the remainder."""
    result: List[List[List[Any]]] = []
    seq_set = list(seq)
    for a in combinations(2, seq_set):
        rem1 = [x for x in seq_set if x not in a]
        for b in combinations(3, rem1):
            rem2 = [x for x in rem1 if x not in b]
            result.append([a, b, rem2])
    return result


def group(seq: Sequence[Any], sizes: Sequence[int]) -> List[List[List[Any]]]:
    """Group the elements of ``seq`` into disjoint subsets of the specified sizes.

    The order of the resulting groups is irrelevant; duplicate partitions (where
    the same subsets appear in a different order) are removed.  Each element of
    ``seq`` appears in exactly one subset.  For example, grouping four items
    into two pairs yields three unique groupings rather than six permutations.

    This implementation generates partitions recursively using combinations and
    then deduplicates the results by sorting the groups and using a set to
    eliminate equivalent partitions.
    """
    if not sizes:
        return [[]]
    first, *rest = sizes
    partial_results: List[List[List[Any]]] = []
    for comb in combinations(first, seq):
        remaining = [x for x in seq if x not in comb]
        for rest_groups in group(remaining, rest):
            partial_results.append([list(comb)] + rest_groups)
    # Deduplicate partitions: sort each subgroup and then sort the list of groups.
    unique: Dict[Tuple[Tuple[Any, ...], ...], List[List[Any]]] = {}
    for groups in partial_results:
        # Normalize each subgroup and the order of subgroups for hashing.
        normalized = tuple(sorted(tuple(sorted(subgrp)) for subgrp in groups))
        if normalized not in unique:
            unique[normalized] = groups
    return list(unique.values())


def lsort(seq: Sequence[Sequence[Any]]) -> List[List[Any]]:
    """Sort a list of lists according to length of sublists."""
    return sorted([list(s) for s in seq], key=len)


def lfsort(seq: Sequence[Sequence[Any]]) -> List[List[Any]]:
    """Sort a list of lists according to the frequency of their lengths."""
    lengths = [len(s) for s in seq]
    freq = Counter(lengths)
    return sorted([list(s) for s in seq], key=lambda s: freq[len(s)])


# -----------------------------------------------------------------------------
# Arithmetic problems


def is_prime(n: int) -> bool:
    """Return True if n is prime."""
    if n <= 1:
        return False
    if n <= 3:
        return True
    if n % 2 == 0 or n % 3 == 0:
        return False
    i = 5
    while i * i <= n:
        if n % i == 0 or n % (i + 2) == 0:
            return False
        i += 6
    return True


def gcd(a: int, b: int) -> int:
    """Compute the greatest common divisor using Euclid's algorithm."""
    while b:
        a, b = b, a % b
    return abs(a)


def coprime(a: int, b: int) -> bool:
    """Return True if a and b are coprime."""
    return gcd(a, b) == 1


def totient_phi(m: int) -> int:
    """Euler's totient function phi(m), naive implementation."""
    return sum(1 for r in range(1, m) if coprime(r, m))


def prime_factors(n: int) -> List[int]:
    """Return the prime factors of n in ascending order."""
    factors: List[int] = []
    f = 2
    while n > 1:
        while n % f == 0:
            factors.append(f)
            n //= f
        f += 1
    return factors


def prime_factors_mult(n: int) -> List[Tuple[int, int]]:
    """Return the prime factors and their multiplicities."""
    c = Counter(prime_factors(n))
    return sorted(list(c.items()))


def phi_improved(m: int) -> int:
    """Improved Euler's totient using prime factorisation."""
    result = 1
    for p, k in prime_factors_mult(m):
        result *= (p ** k - p ** (k - 1))
    return result


# -----------------------------------------------------------------------------
# Logic and Codes


def nand(a: bool, b: bool) -> bool:
    return not (a and b)


def nor(a: bool, b: bool) -> bool:
    return not (a or b)


def xor(a: bool, b: bool) -> bool:
    return a != b


def impl(a: bool, b: bool) -> bool:
    return (not a) or b


def equ(a: bool, b: bool) -> bool:
    return a == b


# Helper functions for evaluating prefix boolean expressions used in truth tables.
def _parse_prefix(tokens: List[str]) -> Any:
    """Parse a list of tokens representing a prefix expression with parentheses.

    Returns a nested list structure representing the abstract syntax tree (AST).
    Each sublist begins with an operator followed by its operands.  Atoms
    (variables or constants) are returned as strings.  This parser handles
    parentheses and arbitrary nesting; it assumes that the input is well‑formed.
    """
    if not tokens:
        raise ValueError("Unexpected end of tokens during parsing")
    token = tokens.pop(0)
    if token == '(':  # start of an expression
        if not tokens:
            raise ValueError("Missing operator after '('")
        op = tokens.pop(0)
        args: List[Any] = []
        while tokens and tokens[0] != ')':
            args.append(_parse_prefix(tokens))
        if not tokens or tokens[0] != ')':
            raise ValueError("Missing closing ')' in expression")
        tokens.pop(0)  # consume ')'
        return [op] + args
    elif token == ')':
        raise ValueError("Unexpected ')' in expression")
    else:
        return token


def _eval_ast(ast: Any, env: Dict[str, Any]) -> Any:
    """Evaluate an AST produced by ``_parse_prefix`` in the given environment.

    The environment ``env`` maps variable names and operator symbols to
    corresponding boolean values or functions.  The evaluator supports unary
    operator ``not`` and n‑ary operators such as ``and``, ``or``, ``nand``,
    ``nor``, ``xor``, ``impl`` and ``equ``.  Atoms that match keys in ``env``
    are looked up directly; literal "True" and "False" are interpreted as
    boolean constants.
    """
    # If the AST is a list, evaluate recursively.
    if isinstance(ast, list):
        op = ast[0]
        # Evaluate all operand expressions first
        operands = [ _eval_ast(arg, env) for arg in ast[1:] ]
        # Fetch the operator function from the environment
        if op not in env:
            raise KeyError(f"Unknown operator: {op}")
        func = env[op]
        return func(*operands)
    # Otherwise, it's an atom (variable or constant)
    if isinstance(ast, str):
        if ast == 'True':
            return True
        if ast == 'False':
            return False
        if ast in env:
            return env[ast]
    # If nothing matches, raise
    raise KeyError(f"Unbound symbol: {ast}")


def table(var1: str, var2: str, expr) -> List[List[Any]]:
    """Generate a truth table for a two‑variable logical expression.

    ``expr`` may be either a callable taking two boolean arguments or a
    prefix expression string using parentheses and operator names as defined
    in the Ninety‑Nine problems, such as ``"(and (or A B) (nand A B))"``.  The
    function evaluates the expression for all four combinations of truth
    assignments to ``var1`` and ``var2`` and returns a list of rows of the
    form ``[value_of_var1, value_of_var2, result]``.
    """
    rows: List[List[Any]] = []
    # Determine how to evaluate the expression
    if callable(expr):
        def eval_expr(a: bool, b: bool) -> Any:
            return expr(a, b)
    elif isinstance(expr, str):
        # Parse the prefix expression into an AST once
        tokens = expr.replace('(', ' ( ').replace(')', ' ) ').split()
        ast = _parse_prefix(tokens)
        # Build an environment mapping operator names and variable names to functions/values
        def eval_expr(a: bool, b: bool) -> Any:
            env = {
                var1: a,
                var2: b,
                'nand': nand,
                'nor': nor,
                'xor': xor,
                'impl': impl,
                'equ': equ,
                'and': lambda x, y: x and y,
                'or': lambda x, y: x or y,
                'not': lambda x: not x,
            }
            return _eval_ast(ast, env)
    else:
        raise TypeError("expr must be either a callable or a string")
    # Evaluate for all combinations of True/False for var1 and var2
    for a in [True, False]:
        for b in [True, False]:
            rows.append([a, b, eval_expr(a, b)])
    return rows


def assignments(vars_: Sequence[str]) -> List[Dict[str, bool]]:
    """Generate all assignments of True/False for the given variable names."""
    if not vars_:
        return [{}]
    first, *rest = vars_
    sub = assignments(rest)
    result: List[Dict[str, bool]] = []
    for a in sub:
        result.append({**a, first: True})
        result.append({**a, first: False})
    return result


def table_n(vars_: Sequence[str], expr) -> List[List[Any]]:
    """Generate a truth table for a logical expression over multiple variables.

    ``vars_`` is a sequence of variable names (strings).  ``expr`` may be a
    callable accepting the same number of boolean arguments as there are
    variables, or a prefix expression string using parentheses and the
    operators defined in the Ninety‑Nine problems.  The function returns a
    list of rows, each consisting of the assigned boolean values for the
    variables followed by the result of the expression.
    """
    rows: List[List[Any]] = []
    if callable(expr):
        def eval_expr(*args: bool) -> Any:
            return expr(*args)
    elif isinstance(expr, str):
        tokens = expr.replace('(', ' ( ').replace(')', ' ) ').split()
        ast = _parse_prefix(tokens)
        def eval_expr(*args: bool) -> Any:
            env = {var: val for var, val in zip(vars_, args)}
            env.update({
                'nand': nand,
                'nor': nor,
                'xor': xor,
                'impl': impl,
                'equ': equ,
                'and': lambda x, y: x and y,
                'or': lambda x, y: x or y,
                'not': lambda x: not x,
            })
            return _eval_ast(ast, env)
    else:
        raise TypeError("expr must be either a callable or a string")
    for assign in assignments(list(vars_)):
        values = [assign[var] for var in vars_]
        rows.append(values + [eval_expr(*values)])
    return rows


def gray(n: int) -> List[str]:
    """Return the n-bit Gray code sequence."""
    if n < 0:
        raise ValueError("n must be non-negative")
    if n == 0:
        return [""]
    if n == 1:
        return ["0", "1"]
    prev = gray(n - 1)
    return ["0" + x for x in prev] + ["1" + x for x in reversed(prev)]


def huffman(freqs: List[Tuple[Any, int]]) -> List[Tuple[Any, str]]:
    """Return the Huffman code for a frequency table."""
    # Build initial forest of leaf nodes
    forest = [({'symbol': sym, 'freq': freq}, None, None) for sym, freq in freqs]
    # Each node is a tuple (node, left, right) where node is dict containing freq and symbol(s)
    while len(forest) > 1:
        # Sort forest by frequency
        forest.sort(key=lambda t: t[0]['freq'])
        (node1, left1, right1), (node2, left2, right2), *rest = forest
        merged = ({'symbol': (node1['symbol'], node2['symbol']),
                   'freq': node1['freq'] + node2['freq']},
                  (node1, left1, right1),
                  (node2, left2, right2))
        forest = rest + [merged]
    tree = forest[0]

    codes: Dict[Any, str] = {}
    def assign_codes(node, left, right, prefix: str):
        sym = node['symbol']
        if not isinstance(sym, tuple):
            codes[sym] = prefix or "0"  # assign "0" if single symbol
        else:
            # Left child gets "0", right child gets "1"
            n_left, l_left, r_left = left
            n_right, l_right, r_right = right
            assign_codes(n_left, l_left, r_left, prefix + "0")
            assign_codes(n_right, l_right, r_right, prefix + "1")
    node0, left0, right0 = tree
    assign_codes(node0, left0, right0, "")
    return [(sym, codes[sym]) for sym, _ in freqs]


__all__ = [
    'my_last', 'my_but_last', 'element_at', 'my_count', 'my_reverse', 'palindrome',
    'flatten_list', 'compress', 'pack', 'encode', 'encode_modified', 'decode',
    'encode_direct', 'dupli', 'repli', 'drop_every', 'split', 'slice_', 'rotate',
    'remove_at', 'insert_at', 'range_list', 'rnd_select', 'lotto_select',
    'rnd_permu', 'combinations', 'group3', 'group', 'lsort', 'lfsort',
    'is_prime', 'gcd', 'coprime', 'totient_phi', 'prime_factors',
    'prime_factors_mult', 'phi_improved', 'nand', 'nor', 'xor', 'impl', 'equ',
    'table', 'assignments', 'table_n', 'gray', 'huffman'
]