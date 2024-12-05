import algorithm, sets, strutils, sugar, sequtils

type Page = int

let rules = collect:
  for line in "input.txt".lines:
    if line.contains '|':
      let split = line.split '|'
      {(split[0].parseInt.Page, split[1].parseInt.Page)}

proc pageCmp(a, b: Page): int =
  if rules.contains (a, b): -1
  elif rules.contains (b, a): 1
  else: 0

var sum = 0
for line in "input.txt".lines:
  if line.contains ',':
    let pages = line.split(',').mapIt(it.parseInt.Page)
    if not pages.isSorted(pageCmp):
      let sorted = pages.sorted(pageCmp)
      sum += sorted[sorted.high div 2]

echo sum
