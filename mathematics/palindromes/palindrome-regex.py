# Question: https://stackoverflow.com/questions/62838784/optimize-time-space-complexity-for-solving-palindromes

import re
import time


def longestPalindrome(string, longest_first=True):
    palindrome = None
    order = range(len(string)//2, -1, -1) if longest_first else range(1, len(string)//2+1)
    for n in order:
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
            if longest_first:
                return palindrome  # return the first match
        else:
            if not longest_first:
                break  # return the last match

    return palindrome


if __name__ == '__main__':
    for longest_first in [True, False]:
        print(f'\nLongest First = {longest_first}')
        for sentence in [
            "banana",
            "tracecars",
            "detartrated",
            "saippuakivikauppias",
            "this is not the palindrome you are looking for"
        ]:
            start_time = time.perf_counter()
            answer     = longestPalindrome(sentence, longest_first)
            time_taken = time.perf_counter() - start_time
            print(f'len({len(sentence):2d}) in {1000*time_taken:6.2f}ms = longestPalindrome({sentence}, {longest_first}) == {answer}')

    assert longestPalindrome("banana")      == "anana"
    assert longestPalindrome("tracecars")   == "racecar"
    assert longestPalindrome("detartrated") == "detartrated"


### Output
# Longest First = True
# len( 6) in   0.79ms = longestPalindrome(banana, True) == anana
# len( 9) in   0.39ms = longestPalindrome(tracecars, True) == racecar
# len(11) in   0.41ms = longestPalindrome(detartrated, True) == detartrated
# len(19) in   0.59ms = longestPalindrome(saippuakivikauppias, True) == saippuakivikauppias
# len(46) in  13.19ms = longestPalindrome(this is not the palindrome you are looking for, True) == oo
#
# Longest First = False
# len( 6) in   0.06ms = longestPalindrome(banana, False) == anana
# len( 9) in   0.08ms = longestPalindrome(tracecars, False) == racecar
# len(11) in   0.19ms = longestPalindrome(detartrated, False) == detartrated
# len(19) in   0.46ms = longestPalindrome(saippuakivikauppias, False) == saippuakivikauppias
# len(46) in   0.04ms = longestPalindrome(this is not the palindrome you are looking for, False) == oo