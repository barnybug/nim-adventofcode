import future
import re
import strutils
import tables

type WireProc = proc(): uint16

var wires = initTable[string, WireProc]()
var cache = initTable[string, uint16]()

proc lookup(name: string): uint16 =
  if name in cache:
    result = cache[name]
  else:
    try: result = uint16 parseInt name
    except: result = wires[name]()
    cache[name] = result

for line in lines "input.txt":
  var m = newSeq[string](3)
  if line.match(re"(\w+)\s->\s(\w+)", m):
    wires[m[1]] = () => lookup(m[0])
  elif line.match(re"NOT\s(\w+)\s->\s(\w+)", m):
    wires[m[1]] = () => not lookup(m[0])
  elif line.match(re"(\w+)\sAND\s(\w+)\s->\s(\w+)", m):
    wires[m[2]] = () => lookup(m[0]) and lookup(m[1])
  elif line.match(re"(\w+)\sOR\s(\w+)\s->\s(\w+)", m):
    wires[m[2]] = () => lookup(m[0]) or lookup(m[1])
  elif line.match(re"(\w+)\sLSHIFT\s(\d+)\s->\s(\w+)", m):
    wires[m[2]] = () => lookup(m[0]) shl uint16(parseInt(m[1]))
  elif line.match(re"(\w+)\sRSHIFT\s(\d+)\s->\s(\w+)", m):
    wires[m[2]] = () => lookup(m[0]) shr uint16(parseInt(m[1]))
  else:
    echo "Bad: ", line

var ans1 = wires["a"]()
echo "Answer #1: ", ans1

# override b with value from a, and calculate new signal for a
cache = initTable[string, uint16]()
cache["b"] = ans1
echo "Answer #2: ", wires["a"]()
