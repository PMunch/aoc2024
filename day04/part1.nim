import std/[strutils, setutils]

type
  Direction = enum
    North, NorthEast, East, SouthEast, South, SouthWest, West, NorthWest

const word = "XMAS"

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

var count = 0
for y in 0..input.high:
  for x in 0..input[y].high:
    if input[y][x] == word[0]:
      for dir in validDirections(x, y):
        var stepPos = step(x, y, dir)
        for i in 1..word.high:
          if input[stepPos.y][stepPos.x] == word[i]:
            if i == word.high:
              inc count
          else: break
          stepPos = step(stepPos.x, stepPos.y, dir)
          if stepPos.x notin 0..input[y].high or stepPos.y notin 0..input.high:
            break

echo count
