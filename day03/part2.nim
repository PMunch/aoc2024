import strscans

let input = readFile("input.txt")

var
  sum = 0
  mulEnabled = true

for i in 0..input.high:
  var a, b: int
  if input[i] notin {'m','d'}: continue
  let slice = input[i..^1]
  if scanf(slice, "mul($i,$i)", a, b):
    if mulEnabled and a in 0..999 and b in 0..999:
      echo a, "*", b, "=", a*b
      sum += a*b
  elif scanf(slice, "do()"):
    mulEnabled = true
  elif scanf(slice, "don't()"):
    mulEnabled = false

echo sum
