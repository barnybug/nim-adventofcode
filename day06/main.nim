import nre
import options
import sequtils
import strutils

var reCoords = re"(\d+),(\d+)\sthrough\s(\d+),(\d+)"

type Grid = array[1000, array[1000, bool]]
type BGrid = array[1000, array[1000, uint8]]

proc main() =
  var lights: Grid
  var blights: BGrid
  for line in lines "input.txt":
    var m = line.find(reCoords)
    var ns = nre.toSeq(m.get.captures).map(parseInt)
    for x in ns[0]..ns[2]:
      for y in ns[1]..ns[3]:
        if line.startsWith("turn on"):
          lights[x][y] = true
          inc blights[x][y]
        elif line.startsWith("turn off"):
          lights[x][y] = false
          if blights[x][y] != 0:
            dec blights[x][y]
        elif line.startsWith("toggle"):
          lights[x][y] = not lights[x][y]
          blights[x][y] += 2

  var ans1, ans2: int
  for row in lights:
    for cell in row:
      if cell:
        inc ans1

  for row in blights:
    for cell in row:
      ans2 += int(cell)

  echo "Answer #1: ", ans1
  echo "Answer #2: ", ans2

main()
