import strutils, sequtils

var map = readFile("input.txt").splitLines.filterIt(it.len != 0).mapIt(it.mapIt(it.ord - ord('0')))

var trailheads: seq[tuple[x, y: int]]
for y, row in map:
  for x, elev in row:
    if elev == 0:
      trailheads.add (x, y)

proc score(pos: tuple[x, y: int]): int =
  if map[pos.y][pos.x] == 9:
    return 1
  if pos.x != 0 and map[pos.y][pos.x - 1] == map[pos.y][pos.x] + 1:
    result += score (pos.x - 1, pos.y)
  if pos.y != 0 and map[pos.y - 1][pos.x] == map[pos.y][pos.x] + 1:
    result += score((pos.x, pos.y - 1))
  if pos.x != map[0].high and map[pos.y][pos.x + 1] == map[pos.y][pos.x] + 1:
    result += (pos.x + 1, pos.y).score
  if pos.y != map.high and map[pos.y + 1][pos.x] == map[pos.y][pos.x] + 1:
    result += score (pos.x, pos.y + 1)

var total = 0
for trailhead in trailheads:
  total += trailhead.score

echo total
