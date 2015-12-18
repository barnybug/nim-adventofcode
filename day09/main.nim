import combinatorics
import re
import sequtils
import strutils
import tables

let regex = re"(\S+)\sto\s(\S+)\s=\s(\d+)"
var matches: array[3, string]
var costs = initTable[(string, string), int]()
var nodes = newSeq[string]()
for line in lines "input.txt":
  if line.find(regex, matches) != -1:
    var
      a = matches[0]
      b = matches[1]
      units = parseInt(matches[2])
    if a notin nodes: nodes.add(a)
    if b notin nodes: nodes.add(b)

    costs[(a,b)] = units
    costs[(b,a)] = units

proc score(route: openarray[string]): int =
  let ln = route.len
  for i in 0..<ln-1:
    if (route[i], route[i+1]) notin costs:
      return high(int)
    result += costs[(route[i], route[i+1])]

proc calcBest(nodes: seq[string]): int =
  result = high(int)
  for route in permutations(nodes):
    var s = score(route)
    if s < result:
      result = s

proc calcWorst(nodes: seq[string]): int =
  result = 0
  for route in permutations(nodes):
    var s = score(route)
    if s > result:
      result = s

echo "Answer #1: ", calcBest(nodes)
echo "Answer #2: ", calcWorst(nodes)
