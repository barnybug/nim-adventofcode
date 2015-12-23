import future
import sequtils
import strutils
import tables

proc run(a: uint, b: uint): uint =
  var code = readFile("input.txt").splitLines
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
      pc += parseInt(code[pc].split[1])
    of "jie":
      if regs[reg] mod 2 == 0: pc += parseInt(code[pc].split[2])
      else: inc pc
    of "jio":
      if regs[reg] == 1: pc += parseInt(code[pc].split[2])
      else: inc pc
    else:
      discard

  result = regs['b']

echo "Answer #1: ", run(0, 0)
echo "Answer #2: ", run(1, 0)