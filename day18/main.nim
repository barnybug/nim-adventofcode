import re, sequtils, sets, strutils

type Pos = tuple[x: int, y: int]
type Grid = HashSet[Pos]

proc iteration(lights: var Grid) =
  var current = lights
  lights = initSet[Pos]()
  for x in 0..<100:
    for y in 0..<100:
      var neighbours = 0
      for n in [(-1, -1), (-1, 0), (-1, 1), (0, 1), (1, 1), (1, 0), (1, -1), (0, -1)]:
        if (x+n[0], y+n[1]) in current:
          inc neighbours

      if ((x, y) in current and (neighbours == 2 or neighbours == 3)) or
        ((x, y) notin current and neighbours == 3):
        lights.incl((x,y))

proc loadInput(): Grid =
  var lights: Grid = initSet[Pos]()
  var y = 0
  for line in lines "input.txt":
    for x, ch in pairs line:
      if ch == '#':
        lights.incl((x,y))
    inc y

  return lights

const corners = [(0,0),(0,99),(99,0),(99,99)].toSet

proc answer1(): int =
  var lights = loadInput()
  for i in 1..100:
    iteration(lights)
  return lights.len

proc answer2(): int =
  var lights = loadInput()
  for i in 1..100:
    lights.incl corners
    iteration(lights)
  lights.incl corners
  return lights.len

echo "Answer #1: ", answer1()
echo "Answer #2: ", answer2()
