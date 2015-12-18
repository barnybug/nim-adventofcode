import sequtils

proc count(s: seq[byte]): seq[byte] =
  result = @[]
  var prev = s[0]
  var count: byte = 1
  var l = len s
  for i in 1..<l:
    if s[i] == prev:
      inc count
    else:
      result.add([count, prev])
      count = 1
      prev = s[i]

  result.add([count, prev])

var input = "1321131112".mapIt((byte)it)
for i in 1..50:
  input = count(input)
  if i == 40 or i == 50:
    echo i, " ", len input
