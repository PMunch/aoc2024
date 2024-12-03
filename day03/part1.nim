import strscans

let input = readFile("input.txt")

var sum = 0
for i in 0..input.high:
  var a, b: int
  if input[i] != 'm': continue
  if scanf(input[i..^1], "mul($i,$i)", a, b):
    if a in 0..999 and b in 0..999:
      #echo a, "*", b, "=", a*b
      sum += a*b

echo sum
