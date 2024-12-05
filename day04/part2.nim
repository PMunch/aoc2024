import std/[strutils, setutils, sequtils]

type
  Direction = enum
    North, NorthEast, East, SouthEast, South, SouthWest, West, NorthWest

let input = readFile("input.txt").split("\n")[0..^2]

proc validDirections(x, y: int): set[Direction] =
  result = Direction.fullSet
  if x == 0:
    result.excl West
    result.excl NorthWest
    result.excl SouthWest
  if x == input[0].high:
    result.excl East
    result.excl NorthEast
    result.excl SouthEast
  if y == 0:
    result.excl North
    result.excl NorthWest
    result.excl NorthEast
  if y == input.high:
    result.excl South
    result.excl SouthWest
    result.excl SouthEast

proc step(x, y: int, dir: Direction): tuple[x, y: int] =
  case dir:
  of North: (x, y-1)
  of NorthEast: (x+1, y-1)
  of East: (x+1, y)
  of SouthEast: (x+1, y+1)
  of South: (x, y+1)
  of SouthWest: (x-1, y+1)
  of West: (x-1, y)
  of NorthWest: (x-1, y-1)

proc peek(x, y: int, dir: Direction): char =
  let step = step(x, y, dir)
  input[step.y][step.x]

var count = 0
for y in 0..input.high:
  for x in 0..input[y].high:
    if input[y][x] == 'A':
      let validDirections = validDirections(x, y)
      block validCheck:
        for check in [{NorthWest, SouthEast}, {SouthWest, NorthEast}]:
          if (check * validDirections).toSeq.mapIt(peek(x, y, it)).toSet != {'M', 'S'}:
            break validCheck
        inc count

echo count
