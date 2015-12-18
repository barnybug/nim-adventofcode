import md5
import strutils

var secret = "ckczppom"
proc adventcoin(prefix: string): int =
  for i in 1..int.high:
    if getMD5(secret & $i).startsWith(prefix):
      return i

echo "Answer #1: ", adventcoin("00000")
echo "Answer #2: ", adventcoin("000000")