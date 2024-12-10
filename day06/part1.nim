import std/enumerate

type
  Direction = enum
    North, East, South, West
  Position = uint16

var
  obstacles: set[Position]
  visited: set[Position]
  guardPos: tuple[x, y: int]
  currentDirection = North
  mapWidth: int
  mapHeight: int

template pos(x, y: int): Position =
  if x notin 0..<mapWidth or y notin 0..<mapHeight: Position(uint16.high)
  else: Position(y*mapWidth + x)

for y, line in enumerate("input.txt".lines):
  mapWidth = line.len
  inc mapHeight
  for x, tile in line:
    case tile:
    of '.': discard
    of '#': obstacles.incl pos(x, y)
    of '^': guardPos = (x, y)
    else: quit 1

#echo guardPos
#echo obstacles
#echo mapWidth
#echo mapHeight

while guardPos.x in 0..<mapWidth and guardPos.y in 0..<mapHeight:
  visited.incl pos(guardPos.x, guardPos.y)
  case currentDirection:
  of North: guardPos.y -= 1
  of South: guardPos.y += 1
  of West: guardPos.x -= 1
  of East: guardPos.x += 1

  while true:
    case currentDirection:
    of North:
      if obstacles.contains pos(guardPos.x, guardPos.y - 1): currentDirection = East
      else: break
    of South:
      if obstacles.contains pos(guardPos.x, guardPos.y + 1): currentDirection = West
      else: break
    of West:
      if obstacles.contains pos(guardPos.x - 1, guardPos.y): currentDirection = North
      else: break
    of East:
      if obstacles.contains pos(guardPos.x + 1, guardPos.y): currentDirection = South
      else: break

echo visited.card

for y, line in enumerate("input.txt".lines):
  for x, tile in line:
    if pos(x, y) in visited:
      stdout.write "¤"
    else:
      stdout.write tile
  stdout.write "\n"
