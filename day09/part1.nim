let input = readFile("input.txt")
var output: seq[int]

var
  file = true
  id = 0
for c in input:
  if c notin '0'..'9': continue
  for i in 0..<(ord(c) - ord('0')):
    if file: output.add id
    else: output.add -1
  if file: inc id
  file = not file

var highest = output.high

for i, id in output.mpairs:
  if id == -1:
    while output[highest] == -1:
      dec highest
    if i >= highest: break
    id = output[highest]
    output[highest] = -1

var checksum = 0
for i, id in output:
  if id == -1: break
  checksum += i * id
echo checksum
