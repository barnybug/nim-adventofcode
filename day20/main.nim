import math

var input = 29000000

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

proc answer1b(input: int): int =
  var d = input div 10
  var counts = newSeq[int](d)
  for i in 1..d:
    for j in 1..d div i:
      counts[j*i-1] += i * 10
    if counts[i-1] >= input:
      return i

proc answer2b(input: int): int =
  var d = input div 11
  var counts = newSeq[int](d)
  for i in 1..d:
    for j in 1..min(d div i, 50):
      counts[j*i-1] += i * 11
    if counts[i-1] >= input:
      return i

# echo "Answer #1: ", answer1a(input)
# echo "Answer #2: ", answer2a(input)
echo "Answer #1: ", answer1b(input)
echo "Answer #2: ", answer2b(input)
