import math
import sequtils
import strutils

type Item = ref object
  cost: int
  damage: int
  armour: int

proc `$`(item: Item): string = "Item(cost: $1, damage: $2, armour: $3)".format(item.cost, item.damage, item.armour)

const
  myHit = 100
  bossHit = 104
  bossDamage = 8
  bossArmour = 1

var weapons, armours, rings: seq[Item]

proc parseItem(line: string): Item =
  var ps = line.split[^3..^1].map(parseInt)
  return Item(cost: ps[0], damage: ps[1], armour: ps[2])

proc parseItems() =
  for section in "items.txt".readFile.split("\n\n"):
    var items: seq[Item] = section.splitLines[1..^1].map(parseItem)
    case section.split(":")[0]
    of "Weapons":
      weapons = items
    of "Armor":
      armours = items & @[Item()]
    of "Rings":
      rings = items & @[Item(), Item()]

proc addItems(items: openarray[Item]): Item =
  result = Item()
  for it in items:
    result.cost += it.cost
    result.damage += it.damage
    result.armour += it.armour

proc fight(myDamage: int, myArmour: int): bool =
  var bossStrike = max(bossDamage - myArmour, 1)
  var myStrike = max(myDamage - bossArmour, 1)
  return ceil(bossHit / myStrike) <= ceil(myHit / bossStrike)

iterator toolup(): Item =
  for weapon in weapons:
    for armour in armours:
      for i, leftRing in rings:
        for rightRing in rings[i..rings.high]:
          yield addItems([weapon, armour, leftRing, rightRing])

proc answer1(): int =
  result = int.high
  for combined in toolup():
    if fight(combined.damage, combined.armour):
      result = min(result, combined.cost)

proc answer2(): int =
  result = 0
  for combined in toolup():
    if not fight(combined.damage, combined.armour):
      result = max(result, combined.cost)

parseItems()
echo "Answer #1: ", answer1()
echo "Answer #2: ", answer2()
