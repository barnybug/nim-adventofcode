import re
import sequtils
import strutils
import tables

var regex = re"Sue\s(\d+):\s(.+)"

var dp = initTable[string,int]()

dp["children"] = 3
dp["cats"] = 7
dp["samoyeds"] = 2
dp["pomeranians"] = 3
dp["akitas"] = 0
dp["vizslas"] = 0
dp["goldfish"] = 5
dp["trees"] = 3
dp["cars"] = 2
dp["perfumes"] = 1

type Feature = tuple[feature: string, value: int]
type Auntie = ref object
  sue: int
  features: seq[Feature]

proc parseAuntie(line: string): Auntie =
  var m = newSeq[string](2)
  discard line.match(regex, m)
  var auntie = Auntie(sue: parseInt(m[0]), features: @[])
  var parts = m[1].split(", ")
  for part in parts:
    var m = part.split(": ")
    var name = m[0]
    var val = parseInt(m[1])

    auntie.features.add((name, val))
  return auntie

proc answer(tst: proc(auntie: Auntie): bool): int =
  for line in lines "input.txt":
    var auntie = parseAuntie(line)
    if tst(auntie):
      return auntie.sue

proc answer1(): int =
  answer() do (auntie: Auntie) -> bool:
    for en in auntie.features:
      var (name, val) = en
      var rval = dp[name]
      if rval != val:
        return false
    return true

proc answer2(): int =
  answer() do (auntie: Auntie) -> bool:
    for en in auntie.features:
      var (name, val) = en
      var rval = dp[name]
      if (name == "cats" or name == "trees"):
        if val <= rval:
          return false
      elif (name == "pomeranians" or name == "goldfish"):
        if val >= rval:
          return false
      else:
        if rval != val:
          return false
    return true

echo "Answer #1: ", answer1()
echo "Answer #2: ", answer2()