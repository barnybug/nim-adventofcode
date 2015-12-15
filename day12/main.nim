import json

proc rec(obj: JsonNode): float =
  result = case obj.kind
  of JObject:
    var total = 0.0
    for k, val in pairs(obj):
      total += rec(val)
    total
  of JArray:
    var total = 0.0
    for en in obj:
      total += rec(en)
    total
  of JInt: float(obj.num)
  of JFloat: obj.fnum
  else: 0.0

proc sumJson(obj: JsonNode, pred: proc (item: JsonNode): bool {.closure.}): float =
  if not pred(obj):
    return 0.0

  result = case obj.kind
  of JObject:
    var total = 0.0
    for k, val in pairs(obj):
      total += sumJson(val, pred)
    total
  of JArray:
    var total = 0.0
    for en in obj:
      total += sumJson(en, pred)
    total
  of JInt: float(obj.num)
  of JFloat: obj.fnum
  else: 0.0

proc notRed(item: JsonNode): bool =
  if item.kind == JObject:
    for k, val in pairs(item):
      if val.kind == JString and val.str == "red":
          return false
  return true

var data = parseFile("input.json")
echo "Answer #1: ", sumJson(data, proc(item: JsonNode): bool = true)
echo "Answer #2: ", sumJson(data, notRed)
