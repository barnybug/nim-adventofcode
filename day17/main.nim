import sequtils
import strutils

iterator combinations[T](li: openarray[T], n: int): seq[T] =
  let m = len(li)
  var c = newSeq[int](n)
  var mi = newSeq[T](n)
  for i in 0 .. <n:
    c[i] = i
 
  block outer:
    while true:
      for i in 0..<n:
        mi[i] = li[c[i]]
      yield mi
 
      var i = n-1
      inc c[i]
      if c[i] <= m - 1: continue
 
      while c[i] >= m - n + i:
        dec i
        if i < 0: break outer
      inc c[i]
      while i < n-1:
        c[i+1] = c[i] + 1
        inc i
 
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
