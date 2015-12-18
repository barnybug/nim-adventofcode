import nre
import strutils

var reBackslash = re"""\\(\\|"|x[0-9a-f][0-9a-f])"""

proc unescapeN(s: string): string =
  return s[1..len(s)-2].replace(reBackslash, ".")

var ans1, ans2: int
for line in lines "input.txt":
  ans1 += len(line) - len(unescapeN(line))
  ans2 += len(escape(line)) - len(line)

echo "Answer #1: ", ans1
echo "Answer #2: ", ans2
