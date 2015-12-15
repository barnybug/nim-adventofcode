import re
import strutils

var reBackslash = re"""\\(\\|"|x[0-9a-f][0-9a-f])"""

proc unescape(s: string): string =
  return s[1..len(s)-2].replace(reBackslash, ".")

proc escape(s: string): string =
  return "\"" & s.replace("\\", "\\\\").replace("\"", "\\\"") & "\""

var
  ans1 = 0
  ans2 = 0

for line in lines "input.txt":
  var x = unescape(line)
  ans1 += len(line) - len(x)

  var y = escape(line)
  ans2 += len(y) - len(line)

echo "Answer #1: ", ans1
echo "Answer #2: ", ans2
