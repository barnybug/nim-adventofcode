type Item = ref object
  cost: int
  damage: int
  armour: int

# Weapons:    Cost  Damage  Armor
# Dagger        8     4       0
# Shortsword   10     5       0
# Warhammer    25     6       0
# Longsword    40     7       0
# Greataxe     74     8       0
var weapons = [
  Item(cost: 8, damage: 4),
  Item(cost: 10, damage: 5),
  Item(cost: 25, damage: 6),
  Item(cost: 40, damage: 7),
  Item(cost: 74, damage: 8),
]

# Armor:      Cost  Damage  Armor
# Leather      13     0       1
# Chainmail    31     0       2
# Splintmail   53     0       3
# Bandedmail   75     0       4
# Platemail   102     0       5
var armours = [
  Item(cost: 13, armour: 1),
  Item(cost: 31, armour: 2),
  Item(cost: 53, armour: 3),
  Item(cost: 75, armour: 4),
  Item(cost: 102, armour: 5),
  Item(cost: 0, armour: 0), # optional
]

# Rings:      Cost  Damage  Armor
# Damage +1    25     1       0
# Damage +2    50     2       0
# Damage +3   100     3       0
# Defense +1   20     0       1
# Defense +2   40     0       2
# Defense +3   80     0       3
var rings = [
  Item(cost: 0, armour: 0), # optional
  Item(cost: 0, armour: 0), # optional
  Item(cost: 25, damage: 1, armour: 0),
  Item(cost: 50, damage: 2, armour: 0),
  Item(cost: 100, damage: 3, armour: 0),
  Item(cost: 20, damage: 0, armour: 1),
  Item(cost: 40, damage: 0, armour: 2),
  Item(cost: 80, damage: 0, armour: 3),
]

proc addItems(items: openarray[Item]): Item =
  result = Item()
  for it in items:
    result.cost += it.cost
    result.damage += it.damage
    result.armour += it.armour

proc fight(myDamage: int, myArmour: int): bool =
  var
    myHit = 100
    bossHit = 104
    bossDamage = 8
    bossArmour = 1

  while true:
    # we start
    bossHit -= myDamage - bossArmour
    if bossHit <= 0:
      return true

    # boss goes
    myHit -= bossDamage - myArmour
    if myHit <= 0:
      return false

proc answer1(): int =
  var minGold = int.high

  for weapon in weapons:
    for armour in armours:
      for i, leftRing in rings:
        for rightRing in rings[i..rings.high]:
          var combined = addItems([weapon, armour, leftRing, rightRing])
          if fight(combined.damage, combined.armour):
            minGold = min(minGold, combined.cost)

  return minGold

proc answer2(): int =
  var maxGold = int.low

  for weapon in weapons:
    for armour in armours:
      for i, leftRing in rings:
        for rightRing in rings[i..rings.high]:
          var combined = addItems([weapon, armour, leftRing, rightRing])
          if not fight(combined.damage, combined.armour):
            maxGold = max(maxGold, combined.cost)

  return maxGold

echo "Answer #1: ", answer1()
echo "Answer #2: ", answer2()
