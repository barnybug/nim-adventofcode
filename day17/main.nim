import combinatorics
import sequtils
import strutils

template sum(list: openarray[expr]): expr =
  foldl(list, a + b)

proc answer1(containers: openarray[int], target: int): int =
  for n in 1..len(containers):
    for pick in combinations(containers, n):
      var total = sum(pick)
      if total == target:
        result += 1

proc answer2(containers: openarray[int], target: int): int =
  for n in 1..len(containers):
    for pick in combinations(containers, n):
      var total = sum(pick)
      if total == target:
        result += 1

    # break on the shortest combination
    if result > 0:
      break

var containers = newSeq[int](0)
for line in lines "input.txt":
  containers.add(parseInt(line))

echo "Answer #1: ", answer1(containers, 150)
echo "Answer #2: ", answer2(containers, 150)
