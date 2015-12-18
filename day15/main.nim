
proc score(sprinkles: int, peanutButter: int, frosting: int, sugar: int): (int, int) =
  # Sprinkles: capacity 5, durability -1, flavor 0, texture 0, calories 5
  # PeanutButter: capacity -1, durability 3, flavor 0, texture 0, calories 1
  # Frosting: capacity 0, durability -1, flavor 4, texture 0, calories 6
  # Sugar: capacity -1, durability 0, flavor 0, texture 2, calories 8
  var
    capacity = 5*sprinkles -1*peanutButter -1*sugar
    durability = -sprinkles + 3*peanutButter - frosting
    flavor = 4*frosting
    texture = 2*sugar
    calories = 5*sprinkles + peanutButter + 6*frosting + 8*sugar

  if capacity <= 0 or durability <= 0 or flavor <= 0 or texture <= 0:
    return (0, 0)
  else:
    return (capacity * durability * flavor * texture, calories)

var max, max2: int
for sprinkles in 0..100:
  for peanutButter in 0..(100-sprinkles):
    for frosting in 0..(100-sprinkles-peanutButter):
      for sugar in 0..(100-sprinkles-peanutButter-frosting):
        var (s, calories) = score(sprinkles, peanutButter, frosting, sugar)
        if s > max:
          max = s
        if calories == 500:
          if s > max2:
            max2 = s

echo "Answer #1: ", max
echo "Answer #2: ", max2