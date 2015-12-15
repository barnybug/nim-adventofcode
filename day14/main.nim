import re
import sequtils
import strutils

type Reindeer = ref object
  name: string
  speed, duration, rest, distance, points: int

let regex = re"(\S+)\scan\sfly\s(\d+)\skm/s\sfor\s(\d+)\sseconds,\sbut\sthen\smust\srest\sfor\s(\d+)\sseconds."

var matches: array[4, string]
var reindeers = newSeq[Reindeer]()
for line in lines "input.txt":
  if line.find(regex, matches) != -1:
    var deer = Reindeer(name: matches[0], speed: parseInt(matches[1]),
      duration: parseInt(matches[2]), rest: parseInt(matches[3]))
    reindeers.add(deer)

for t in 0..2503:
  for deer in reindeers:
    var toff = t mod (deer.duration + deer.rest)
    if toff < deer.duration:
      deer.distance += deer.speed

  let furthest = max reindeers.mapIt(it.distance)
  for deer in reindeers:
    if deer.distance == furthest:
      deer.points += 1

echo "answer 1: ", max reindeers.mapIt(it.distance)
echo "answer 2: ", max reindeers.mapIt(it.points)
