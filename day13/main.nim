import combinatorics, nre, options, sequtils, strutils, tables

let regex = re"(\S+)\swould\s(gain|lose)\s(\d+)\shappiness\sunits\sby\ssitting\snext\sto\s(\S+)."
var costs = initTable[(string, string), int]()
var names = newSeq[string]()
for line in lines "input.txt":
  var m = line.find(regex)
  if m.isSome:
    var c = m.get.captures
    var units = parseInt(c[2])
    if c[1] == "lose":
      units = -units
    if c[0] notin names:
      names.add(c[0])
    costs[(c[0],c[3])] = units

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
