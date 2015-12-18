var input = readFile "input.txt"

var pos = 0
var basement = 0
for i, ch in pairs input:
  case ch
  of '(': inc pos
  of ')':dec pos
  else: discard
  if pos < 0 and basement == 0:
    basement = i

echo "Answer #1: ", pos
echo "Answer #2: ", (basement+1)
