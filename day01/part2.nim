import strutils, tables

var
  left: seq[int]
  right: CountTable[int]

for line in "input.txt".lines:
  let split = line.split()
  left.add split[0].parseInt
  right.inc split[^1].parseInt

var similarity = 0
for num in left:
  similarity += num * right[num]

echo similarity
