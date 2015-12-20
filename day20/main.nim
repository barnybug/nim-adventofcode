import math

proc answer1a(input: int): int =
  var target = input div 10
  for house in 1..int.high:
    var p = 0
    for x in 1..int(sqrt(float(house))):
      if house mod x == 0:
        var y = house div x
        if x == y:
          p += x
        else:
          p += x + y

    if p >= target:
      result = house
      break

proc answer2a(input: int): int =
  var target = input div 11
  for house in 1..int.high:
    var p = 0
    for x in 1..int(sqrt(float(house))):
      if house mod x == 0:
        var m = house div x
        if m <= 50:
          p += x
        if m != x and x <= 50:
          p += m
    if p >= target:
      result = house
      break

proc answer(input: int, m: int, limit: int): int =
  var d = input div m
  var counts = newSeq[int](d)
  for i in 1..d:
    for j in 1..min(d div i, limit):
      counts[j*i-1] += i * m
    if counts[i-1] >= input:
      return i

# echo "Answer #1: ", answer1a(29000000)
# echo "Answer #2: ", answer2a(29000000)
echo "Answer #1: ", answer(29000000, 10, int.high)
echo "Answer #2: ", answer(29000000, 11, 50)
