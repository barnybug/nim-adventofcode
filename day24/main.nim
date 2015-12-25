import math, sequtils, sets, strutils, combinatorics

var packages = toSeq(lines "input.txt").map(parseInt)
var total = sum(packages)

proc answer(packages: openarray[int], stotal: int, groups: int): int =
  let pset = packages.toSet
  for i in 1..len packages:
    var minqe = int.high
    var remain = newSeq[int](len(packages)-i)
    for combi in combinations(packages, i):
      if sum(combi) == stotal:
        let remain = pset - combi.toSet
        if groups > 1 and answer(toSeq(remain.items), stotal, groups-1) < int.high:
          # check the remaining packages form a valid answer
          minqe = min(minqe, foldl(combi, a * b))
    if minqe < int.high:
      return minqe

proc answer1(): int =
  answer(packages, total div 3, 3)

proc answer2(): int =
  answer(packages, total div 4, 4)

echo "Answer #1 ", answer1()
echo "Answer #2 ", answer2()
