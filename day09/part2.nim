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

dec id

var span = 0
for i in countdown(output.high, 0):
  if output[i] == -1 or output[i] > id: continue
  if output[i] != id:
    var
      s = 0
      ai = i
    while output[ai] != id: inc ai
    dec ai
    while s < ai:
      var openSpan = 0
      while output[s] == -1:
        inc openSpan
        inc s
      if openSpan >= span:
        for ii in 0..<span:
          output[s - openSpan + ii] = output[ai + 1 + ii]
          output[ai + 1 + ii] = -1
        s = ai
        break
      inc s
    span = 1
    dec id
  else:
    inc span

var checksum = 0
for i, id in output:
  if id == -1: continue
  checksum += i * id
echo checksum
