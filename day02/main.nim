import algorithm
import re
import sequtils
import strutils

let regex = re"(\d+)x(\d+)x(\d+)"

proc parse(line: string): (int, int, int) =
  var m = newSeq[string](3)
  assert line.find(regex, m) > -1
  var arr = m.map(parseInt).sorted(cmp)
  return (arr[0], arr[1], arr[2])

proc squareFoot(x, y, z: int): int =
  return 2*x*y + 2*x*z + 2*y*z + x*y

proc ribbon(x, y, z: int): int =
  return 2*x + 2*y + x*y*z

var area, rib: int
for line in lines "input.txt":
  var (x, y, z) = parse(line)
  area += squareFoot(x, y, z)
  rib += ribbon(x, y, z)

echo "Answer #1: ", area
echo "Answer #2: ", rib
