import strutils, sequtils

var map = readFile("input.txt").splitLines.filterIt(it.len != 0).mapIt(it.mapIt(it.ord - ord('0')))

var trailheads: seq[tuple[x, y: int]]
for y, row in map:
  for x, elev in row:
    if elev == 0:
      trailheads.add (x, y)

type Position = uint16

template pos(x, y: int): Position =
  if x notin 0..<map[0].len or y notin 0..<map.len: Position(uint16.high)
  else: Position(y*map[0].len + x)

proc score(pos: tuple[x, y: int]): set[Position] =
  if map[pos.y][pos.x] == 9:
    result.incl pos(pos.x, pos.y)
  if pos.x != 0 and map[pos.y][pos.x - 1] == map[pos.y][pos.x] + 1:
    result.incl score (pos.x - 1, pos.y)
  if pos.y != 0 and map[pos.y - 1][pos.x] == map[pos.y][pos.x] + 1:
    result.incl score (pos.x, pos.y - 1)
  if pos.x != map[0].high and map[pos.y][pos.x + 1] == map[pos.y][pos.x] + 1:
    result.incl score (pos.x + 1, pos.y)
  if pos.y != map.high and map[pos.y + 1][pos.x] == map[pos.y][pos.x] + 1:
    result.incl score (pos.x, pos.y + 1)

var total = 0
for trailhead in trailheads:
  total += trailhead.score.card

echo total
