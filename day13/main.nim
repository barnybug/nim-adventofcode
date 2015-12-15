import re
import sequtils
import strutils
import tables

# iterative Boothroyd method
iterator permutations[T](ys: openarray[T]): seq[T] =
  var
    d = 1
    c = newSeq[int](ys.len)
    xs = newSeq[T](ys.len)
 
  for i, y in ys: xs[i] = y
  yield xs
 
  block outer:
    while true:
      while d > 1:
        dec d
        c[d] = 0
      while c[d] >= d:
        inc d
        if d >= ys.len: break outer
 
      let i = if (d and 1) == 1: c[d] else: 0
      swap xs[i], xs[d]
      yield xs
      inc c[d]
 
let regex = re"(\S+)\swould\s(gain|lose)\s(\d+)\shappiness\sunits\sby\ssitting\snext\sto\s(\S+)."
var matches: array[4, string]
var costs = initTable[(string, string), int]()
var names = newSeq[string]()
for line in lines "input.txt":
  if line.find(regex, matches) != -1:
    var
      a = matches[0]
      units = parseInt(matches[2])
      b = matches[3]
    if matches[1] == "lose":
      units = -units

    if not(a in names):
      names.add(a)

    costs[(a,b)] = units

proc score(seating: openarray[string]): int =
  let ln = seating.len
  for i, n in seating:
    var left = seating[(i+ln-1) mod ln]
    var right = seating[(i+1) mod ln]
    result += costs.getOrDefault((n, left)) + costs.getOrDefault((n, right))
  return

proc calcBest(names: seq[string]): int =
  for seating in permutations(names[0..<names.len-1]):
    var s = score(seating & @[names[names.len-1]])
    if s > result:
      result = s

echo "Answer #1: ", calcBest(names)
echo "Answer #2: ", calcBest(names & @["me"])
