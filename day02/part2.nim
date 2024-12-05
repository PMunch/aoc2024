import strutils, sequtils, math

var safeReports = 0
for report in "input.txt".lines:
  let levels = report.split.map(parseInt)
  block levelCheck:
    for l in -1..levels.high:
      var diff = 0
      block safeCheck:
        for i in 0..<levels.high - (if l == levels.high: 1 else: 0):
          if i == l: continue
          let
            newDiff = levels[i] - levels[if i + 1 == l: i + 2 else: i + 1]
            firstIndex = if l == 0: 1 else: 0
          if not (((i == firstIndex) or newDiff.sgn == diff.sgn) and abs(newDiff) in 1..3):
            echo levels, " is unsafe"
            break safeCheck
          diff = newDiff
        inc safeReports
        echo levels, " is safe when ignoring ", l
        break levelCheck

echo safeReports
