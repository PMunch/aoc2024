import std/[enumerate, packedsets]

type
  Direction = enum
    North, East, South, West
  Position = int
  Vector = int

var
  obstacles: Packedset[Position]
  visited: Packedset[Position]
  initialGuardPos: tuple[x, y: int]
  currentDirection = North
  mapWidth: int
  mapHeight: int

template pos(x, y: int): Position =
  if x notin 0..<mapWidth or y notin 0..<mapHeight: Position(uint16.high)
  else: Position(y*mapWidth + x)

template vec(x, y: int, dir: Direction): Vector =
  Vector(dir.int * (mapWidth * mapHeight) + y*mapWidth + x)

for y, line in enumerate("input.txt".lines):
  mapWidth = line.len
  inc mapHeight
  for x, tile in line:
    case tile:
    of '.': discard
    of '#': obstacles.incl pos(x, y)
    of '^': initialGuardPos = (x, y)
    else: quit 1

var loops = 0
for y in 0..<mapHeight:
  for x in 0..<mapWidth:
    var
      guardPos = initialGuardPos
      path: Packedset[Vector]
    currentDirection = North
    if obstacles.contains(pos(x, y)) or (guardPos.x == x and guardPos.y == y): continue
    obstacles.incl pos(x, y)
    if y == guardPos.y - 1 and x == guardPos.x:
      currentDirection = East
    while guardPos.x in 0..<mapWidth and guardPos.y in 0..<mapHeight:
      visited.incl pos(guardPos.x, guardPos.y)
      let currentVector = vec(guardPos.x, guardPos.y, currentDirection)
      if path.contains currentVector:
        inc loops
        break
      path.incl currentVector

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

    obstacles.excl pos(x, y)

echo loops
