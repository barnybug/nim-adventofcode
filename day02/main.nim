import algorithm
import re
import sequtils
import strutils

let regex = re"(\d+)x(\d+)x(\d+)"

proc parse(line: string): (int, int, int) =
  var m = newSeq[string](3)
  discard line.find(regex, m)
  var arr = [parseInt(m[0]), parseInt(m[1]), parseInt(m[2])]
  sort(arr, system.cmp[int])
  return (arr[0], arr[1], arr[2])

proc squareFoot(line: string): int =
  var (x, y, z) = parse(line)
  return 2*x*y + 2*x*z + 2*y*z + x*y

proc ribbon(line: string): int =
  var (x, y, z) = parse(line)
  return 2*x + 2*y + x*y*z

var area = 0
var rib = 0
for line in lines "input.txt":
  area += squareFoot(line)
  rib += ribbon(line)

echo "area: ", area
echo "ribbon: ", rib
