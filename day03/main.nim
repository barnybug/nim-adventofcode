import future
import sets

type Person = tuple[x: int, y: int]

var input = readFile "input.txt"

proc move(person: var Person, ch: char) =
  case ch
  of '^': inc person.y
  of 'v': dec person.y
  of '>': inc person.x
  of '<': dec person.x
  else: discard

proc answer(who: (i: int) -> ptr Person): int =
  var places = initSet[Person]()
  places.incl((0, 0))
  for i, ch in pairs input:
    var p = who(i)
    move(p[], ch)
    places.incl(p[])

  return len(places)

proc answer1(): int =
  var santa: Person = (x: 0, y: 0)
  return answer((_: int) => addr santa)

echo "Answer #1: ", answer1()

proc answer2(): int =
  var santa: Person = (x: 0, y: 0)
  var robot: Person = (x: 0, y: 0)
  return answer() do (i: int) -> ptr Person:
    if i mod 2 == 0: addr santa
    else: addr robot

echo "Answer #2: ", answer2()
