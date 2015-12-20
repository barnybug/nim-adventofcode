import math

var input = 29000000

proc presents1(house: int): int =
  result = 0
  for x in 1..int(sqrt(float(house))):
    if house mod x == 0:
      var y = house div x
      if x == y:
        result += x
      else:
        result += x + y

proc presents2(house: int): int =
  result = 0
  for x in 1..int(sqrt(float(house))):
    if house mod x == 0:
      var m = house div x
      if m <= 50:
        result += x
      if m != x and x <= 50:
        result += m

proc example() =
  var x = newSeq[int](9)
  for i in 0..<9:
    x[i] = presents1(i+1)*10
  doAssert x == @[10, 30, 40, 70, 60, 120, 80, 150, 130]

proc answer1a(): int =
  var target = input div 10
  for i in 1..int.high:
    var p = presents1(i)
    if p >= target:
      result = i
      break

proc answer1b(): int =
  # quick but memory hungry approach
  var d = input div 10
  var counts = newSeq[int](d)

  for i in 1..d:
    for j in countup(i, d, i):
      counts[j-1] += i * 10

  for i, n in counts:
    if n >= input:
      return i+1

proc answer2a(): int =
  var target = input div 11
  for i in 1..int.high:
    var p = presents2(i)
    if p >= target:
      result = i
      break

proc answer2b(): int =
  # quick but memory hungry approach
  var d = input div 11
  var counts = newSeq[int](d)

  for i in 1..d:
    var m = d div i
    if m > 50: m = 50
    for j in countup(i, m*i, i):
      counts[j-1] += i * 11

  for i, n in counts:
    if n >= input:
      return i+1

example()
echo "Answer #1: ", answer1a()
echo "Answer #1: ", answer1b()
echo "Answer #2: ", answer2a()
echo "Answer #2: ", answer2b()
