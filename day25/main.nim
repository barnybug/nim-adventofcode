const start = 20151125
const answerRow = 2981
const answerColumn = 3075

proc powmod(b, e, m: int): int =
  assert e >= 0
  var e = e
  var b = b
  result = 1
  while e > 0:
    if e mod 2 == 1:
      result = (result * b) mod m
    e = e div 2
    b = (b*b) mod m

proc answer1(): int =
  var n = (answerRow + answerColumn - 1)
  var steps = n * (n-1) div 2 + answerColumn - 1
  result = (start * powmod(252533, steps, 33554393)) mod 33554393

echo "Answer: ", answer1()
