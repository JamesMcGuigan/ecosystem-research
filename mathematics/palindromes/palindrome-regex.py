# Question: https://stackoverflow.com/questions/62838784/optimize-time-space-complexity-for-solving-palindromes

import re
import time


def longestPalindrome(string):
    for n in range(len(string)//2, -1, -1):
        # Example: re.sub(r'^.*(\w)(\w)(\w)(\w)(\w)?\3\2\1.*$', r'\1\2\3\4\3\2\1', s)
        regex_match = "".join([
            r'^.*',
            r'(\w)' * n,
            r'(\w)?',
            ''.join([ f'\\{i}' for i in range(n,0,-1) ]),
            r'.*$'
        ])
        if re.match(regex_match, string):
            regex_replace = "".join([ f'\\{i}' for i in list(range(1,n+2))+list(range(n,0,-1)) ])
            palindrome    = re.sub(regex_match, regex_replace, string)
            return palindrome
    return None


if __name__ == '__main__':
    for sentence in [
        "banana",
        "tracecars",
        "detartrated",
        "saippuakivikauppias",
        "this is not the palindrome you are looking for"
    ]:
        start_time = time.perf_counter()
        answer     = longestPalindrome(sentence)
        time_taken = time.perf_counter() - start_time
        print(f'len({len(sentence):2d}) in {1000*time_taken:6.2f}ms = longestPalindrome({sentence}) == {answer}')

    assert longestPalindrome("banana")      == "anana"
    assert longestPalindrome("tracecars")   == "racecar"
    assert longestPalindrome("detartrated") == "detartrated"