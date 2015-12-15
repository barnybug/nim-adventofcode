import tables

type Person = tuple[x: int, y: int]

var input = readFile "input.txt"

proc move(person: var Person, ch: char) =
  case ch
  of '^':
    person.y += 1
  of 'v':
    person.y -= 1
  of '>':
    person.x += 1
  of '<':
    person.x -= 1
  else:
    discard

proc answer(who: proc(i: int): ptr Person): int =
  var places = initCountTable[(int, int)]()
  places.inc((0, 0))
  for i, ch in pairs input:
    var p = who(i)
    move(p[], ch)
    places.inc(p[])

  return len(places)

proc answer1(): int =
  var santa: Person = (x: 0, y: 0)
  return answer(proc(i: int): ptr Person = addr santa)

echo "Answer #1: ", answer1()

proc answer2(): int =
  var santa: Person = (x: 0, y: 0)
  var robot: Person = (x: 0, y: 0)
  return answer() do (i: int) -> ptr Person:
    if i mod 2 == 0: addr santa
    else: addr robot


echo "Answer #2: ", answer2()
