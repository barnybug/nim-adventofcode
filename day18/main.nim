import re
import sequtils
import strutils

type Grid = array[0..100, array[0..100, bool]]

proc iteration(lights: var Grid) =
  var current: Grid
  for x in 0..<100:
    for y in 0..<100:
      current[x][y] = lights[x][y]

  for x in 0..<100:
    for y in 0..<100:
      var neighbours = 0
      for n in [(-1, -1), (-1, 0), (-1, 1), (0, 1), (1, 1), (1, 0), (1, -1), (0, -1)]:
        var
          nx = x + n[0]
          ny = y + n[1]
        if nx >= 0 and nx < 100 and ny >= 0 and ny < 100:
          if current[nx][ny]:
            neighbours += 1 

      lights[x][y] =
        (current[x][y] and (neighbours == 2 or neighbours == 3)) or
        (not current[x][y] and neighbours == 3)

proc loadInput(): Grid =
  # set initial state
  var lights: Grid
  var y = 0
  for line in lines "input.txt":
    for x, ch in pairs line:
      lights[x][y] = (ch == '#')
    y += 1

  return lights

proc setCorners(l: var Grid) =
  l[0][0] = true
  l[0][99] = true
  l[99][0] = true
  l[99][99] = true

proc countLit(lights: var Grid): int =
  for row in lights:
    for cell in row:
      if cell:
        result += 1

proc answer1(): int =
  var lights = loadInput()
  for i in 1..100:
    iteration(lights)

  return countLit(lights)

proc answer2(): int =
  var lights = loadInput()
  for i in 1..100:
    setCorners(lights)
    iteration(lights)

  setCorners(lights)
  return countLit(lights)

echo "Answer #1: ", answer1()
echo "Answer #2: ", answer2()
