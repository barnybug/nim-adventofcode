import re
import sequtils
import strutils

var reCoords = re"(\d+),(\d+)\sthrough\s(\d+),(\d+)"
type Point = tuple[x: int, y: int]

type Grid = array[0..1000, array[0..1000, bool]]
type BGrid = array[0..1000, array[0..1000, uint8]]

proc turnOn(p: Point, lights: var Grid) =
  lights[p.x][p.y] = true

proc turnOff(p: Point, lights: var Grid) =
  lights[p.x][p.y] = false

proc toggle(p: Point, lights: var Grid) =
  lights[p.x][p.y] = not lights[p.x][p.y]

proc brighten(p: Point, lights: var BGrid) =
  lights[p.x][p.y] += 1

proc dim(p: Point, lights: var BGrid) =
  if lights[p.x][p.y] != 0:
    lights[p.x][p.y] -= 1

proc brightenMore(p: Point, lights: var BGrid) =
  lights[p.x][p.y] += 2

proc main() =
  var lights: Grid
  var blights: BGrid
  var m = newSeq[string](4)
  for line in lines "input.txt":
    discard line.find(reCoords, m)
    var ns = m.mapIt(parseInt(it))
    var
      x1 = ns[0]
      y1 = ns[1]
      x2 = ns[2]
      y2 = ns[3]

    var fn: proc(p: Point, lights: var Grid)
    var bfn: proc(p: Point, lights: var BGrid)
    if line.startsWith("turn on"):
      fn = turnOn
      bfn = brighten
    elif line.startsWith("turn off"):
      fn = turnOff
      bfn = dim
    elif line.startsWith("toggle"):
      fn = toggle
      bfn = brightenMore

    for x in x1..x2:
      for y in y1..y2:
        var p: Point = (x: x, y: y)
        fn(p, lights)
        bfn(p, blights)

  var ans1 = 0
  for row in lights:
    for cell in row:
      if cell:
        ans1 += 1

  var ans2 = 0
  for row in blights:
    for cell in row:
      ans2 += int(cell)

  echo "Answer #1: ", ans1
  echo "Answer #2: ", ans2

main()
