import algorithm, queues, sets, strutils

var molecules = initSet[string]()
var medicine = readFile "molecule.txt"
var rules = newSeq[(string, string)]()

proc answer1(): int =
  for line in lines "rules.txt":
    var m = line.split(" => ")
    rules.add((m[0], m[1]))

    var pos = medicine.find(m[0])
    while pos > -1:
      var output = medicine[0..<pos] & m[1] & medicine[pos+len(m[0])..^0]
      molecules.incl output
      pos = medicine.find(m[0], pos+1)

  result = len molecules

proc answer2(): int =
  var s = medicine

  # greedy: try longest rules first.
  # This assumes:
  # - there's no shorter path made up by two other rules
  # - the longest doesn't lead to a deadend where a shorter rule wouldn't
  # Don't like these two assumptions, but the answer is right for the given rules.
  rules = rules.sortedByIt(-it[1].len)

  while s != "e":
    for rule in rules:
      var pos = s.find(rule[1])
      while pos > -1:
        s = s[0..<pos] & rule[0] & s[pos+len(rule[1])..^0]
        inc result
        pos = s.find(rule[1], pos+1)

echo "Answer #1: ", answer1()
echo "Answer #2: ", answer2()