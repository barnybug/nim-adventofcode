import md5
import strutils

var secret = "ckczppom"
var prefix = "00000"
for i in 1..high(int):
  var hash = getMD5(secret & $i)
  if hash.startsWith(prefix):
    echo i
    if prefix == "00000":
      # 2nd answer
      prefix = "000000"
    else:
      break
