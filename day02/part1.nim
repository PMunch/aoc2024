import strutils, sequtils, math

var safeReports = 0
for report in "input.txt".lines:
  let levels = report.split.map(parseInt)
  var diff = 0
  block safeCheck:
    for i in 0..<levels.high:
      let newDiff = levels[i] - levels[i + 1]
      if not ((i == 0 or newDiff.sgn == diff.sgn) and abs(newDiff) in 1..3):
        echo levels, " is unsafe"
        break safeCheck
      diff = newDiff
    inc safeReports
    echo levels, " is safe"

echo safeReports
