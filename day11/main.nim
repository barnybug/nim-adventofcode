import strutils
import unittest

var straights = @[
  "abc", "bcd", "cde", "def", "efg", "fgh", "ghi", "hij", "ijk", "jkl", "klm", "lmn", "mno", "nop", "opq", "pqr", "qrs", "rst", "stu", "tuv", "uvw", "vwx", "wxy", "xyz"
]

var twopairs = @[
  "aa", "bb", "cc", "dd", "ee", "ff", "gg", "hh", "jj", "kk", "mm", "nn", "pp", "qq", "rr", "ss", "tt", "uu", "vv", "ww", "xx", "yy", "zz",
]

proc next(s: var string) =
  var cresult: cstring = s
  for i in countdown(len(s)-1, 0):
    var ch = s[i]
    var nch = case ch
    of 'h':
      'j'
    of 'n':
      'p'
    of 'k':
      'm'
    of 'z':
      'a'
    else:
      chr(ord(ch) + 1)

    cresult[i] = nch
    if ch != 'z':
      break

proc containsCount(s: string, subs: openarray[string], min: int): bool =
  var occ = 0
  for p in subs:
    if s.contains(p):
      occ += 1
      if occ == min:
        return true
      else:
        continue

  return false

proc valid(s: string): bool =
  # Passwords must include one increasing straight of at least three
  # letters, like abc, bcd, cde, and so on, up to xyz. They cannot skip
  # letters; abd doesn't count.
  if not containsCount(s, straights, 1):
    return false

  # Passwords may not contain the letters i, o, or l, as these letters can
  # be mistaken for other characters and are therefore confusing.
  if s.contains({'i', 'o', 'l'}):
    return false

  # Passwords must contain at least two different, non-overlapping pairs of
  # letters, like aa, bb, or zz.
  if not containsCount(s, twopairs, 2):
    return false

  return true

proc nextPassword(password: string): string =
  result = password
  next(result)
  while not valid(result):
    next(result)

suite "tests":
  test "next":
    var a = "abc"
    next(a)
    check(a == "abd")
  test "next with carry":
    var a = "abczz"
    next(a)
    check(a == "abdaa")

  test "example 1":
    check(nextPassword("abcdefgh") == "abcdffaa")

  test "example 2":
    check(nextPassword("ghijklmn") == "ghjaabcc")


let input = "vzbxkghb"
var password = nextPassword(input)
echo "Answer #1: ", password
echo "Answer #2: ", nextPassword(password)
