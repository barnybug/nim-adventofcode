import future
import sequtils
import strutils
import tables

proc run(a: uint, b: uint): uint =
  var code = newSeq[string]()
  for line in lines "input.txt":
    code.add(line)

  var regs = initTable[char, uint]()
  regs['a'] = a
  regs['b'] = b
  var pc = 0

  while pc < len code:
    var reg = code[pc][4]
    case code[pc][0..2]:
    of "hlf":
      regs[reg] = regs[reg] div 2
      inc pc
    of "tpl":
      regs[reg] *= 3
      inc pc
    of "inc":
      inc regs[reg]
      inc pc
    of "jmp":
      pc += parseInt(code[pc][4..^1])
    of "jie":
      var i = parseInt(code[pc][7..^1])
      if regs[reg] mod 2 == 0: pc += i
      else: inc pc
    of "jio":
      var i = parseInt(code[pc][7..^1])
      if regs[reg] == 1: pc += i
      else: inc pc
    else:
      discard

  result = regs['b']

echo "Answer #1: ", run(0, 0)
echo "Answer #2: ", run(1, 0)