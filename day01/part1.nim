import strutils, algorithm, math

var
  left, right: seq[int]

for line in "input.txt".lines:
  let split = line.split()
  left.add split[0].parseInt
  right.add split[^1].parseInt

left.sort
right.sort

var totalDistance = 0
for i in left.low..left.high:
  totalDistance += abs(left[i] - right[i])

echo totalDistance
