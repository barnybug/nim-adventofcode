import re
import strutils

var reVowel = re"[aeiou]"
var reDouble = re"(aa|bb|cc|dd|ee|ff|gg|hh|ii|jj|kk|ll|mm|nn|oo|pp|qq|rr|ss|tt|uu|vv|ww|xx|yy|zz)"
var reBad = re"(ab|cd|pq|xy)"

proc isNice(s: string): bool =
  # It contains at least three vowels (aeiou only), like aei, xazegov, or
  # aeiouaeiouaeiou.
  if len(s.findAll(reVowel)) < 3:
    return false

  # It contains at least one letter that appears twice in a row, like xx,
  # abcdde (dd), or aabbccdd (aa, bb, cc, or dd).
  if s.find(reDouble) == -1:
    return false

  # It does not contain the strings ab, cd, pq, or xy, even if they are
  # part of one of the other requirements.
  if s.find(reBad) != -1:
    return false

  return true

proc isNice2(s: string): bool =
  # It contains a pair of any two letters that appears at least twice in
  # the string without overlapping, like xyxy (xy) or aabcdefgaa (aa), but
  # not like aaa (aa, but it overlaps).
  var found = false
  for i in 0..len(s)-1:
    var pair = s[i..i+1]
    if s[i+2..len(s)].contains(pair):
      found = true
      break
  if not found:
    return false

  # It contains at least one letter which repeats with exactly one letter
  # between them, like xyx, abcdefeghi (efe), or even aaa.
  for i in 0..len(s)-2:
    if s[i] == s[i+2]:
      return true
  return false

var ans1 = 0
var ans2 = 0
for line in lines "input.txt":
  if isNice(line):
    ans1 += 1
  if isNice2(line):
    ans2 += 1

echo "Answer #1: ", ans1
echo "Answer #2: ", ans2
