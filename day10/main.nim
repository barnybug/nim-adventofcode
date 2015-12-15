import sequtils

proc count(s: seq[byte]): seq[byte] =
  result = newSeq[byte]()

  var prev = s[0]
  var count: byte = 1
  var l = len s
  for i in 1..<l:
    if s[i] == prev:
      count += 1
    else:
      result.add(count)
      result.add(prev)
      count = 1
      prev = s[i]

  result.add(count)
  result.add(prev)

var input = @[byte(1), byte(3), byte(2), byte(1), byte(1), byte(3), byte(1), byte(1), byte(1), byte(2)]
for i in 1..50:
  input = count(input)
  if i == 40 or i == 50:
    echo i, " ", len input
