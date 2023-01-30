//  day14.swift - AoC 2021

import Foundation

func day14(testData: [String], realData: [String]) {
  // let expectedTestResults = 24    // Part 1
  let expectedTestResults = 93    // Part 2

  let testResults = runCode(data: testData)

  if testResults != expectedTestResults {
    print("Error running tests")
    print("Expected:", expectedTestResults)
    print("Got:", testResults)
    return
  } else {
    print("Tests passed")
    print()
  }

  let realResults = runCode(data: realData)
  print("Results:", realResults)

  func runCode(data: [String]) -> Int {
    var cave: [Location: Terrain] = [:]

    for line in data {
      let bends = line.components(separatedBy: " -> ")
      for index in 0 ..< bends.count - 1 {
        let point1 = bends[index].components(separatedBy: ",")
        let col1 = Int(point1[0])!
        let row1 = Int(point1[1])!

        let point2 = bends[index + 1].components(separatedBy: ",")
        let col2 = Int(point2[0])!
        let row2 = Int(point2[1])!

        // changing row or column?
        var colChange = 0
        if col1 > col2 {
          colChange = -1
        } else if col1 < col2 {
          colChange = 1
        }
        var rowChange = 0
        if row1 > row2 {
          rowChange = -1
        } else if row1 < row2 {
          rowChange = 1
        }

        var col = col1
        var row = row1

        while true {
          cave[Location(row: row, col: col)] = .rock
          if row == row2 && col == col2 {
            break
          }
          row += rowChange
          col += colChange
        }
      }
    }

    // printCave(cave)

    let endRow = cave.keys.reduce(0) { partialResult, loc in
      max(partialResult, loc.row)
    }

    var sandCounter = 0
    while true {
      let finished = dropSand2(cave: &cave, finalRow: endRow)
      // printCave(cave)
      if finished {
        break
      }
      sandCounter += 1
    }

    print(sandCounter)    // Part 1: 592
    return sandCounter
  }

  func dropSand(cave: inout [Location: Terrain], finalRow: Int) -> Bool {
    var sandLoc = Location(row: 0, col: 500)

    while true {
      let nextDown = Location(row: sandLoc.row + 1, col: sandLoc.col)
      var terrain = cave[nextDown, default: .air]
      if sandLoc.row > finalRow {
        return true
      }

      if terrain == .air {
        sandLoc = nextDown
        continue
      }

      let downAndLeft = Location(row: sandLoc.row + 1, col: sandLoc.col - 1)
      terrain = cave[downAndLeft, default: .air]
      if terrain == .air {
        sandLoc = downAndLeft
        continue
      }

      let downAndRight = Location(row: sandLoc.row + 1, col: sandLoc.col + 1)
      terrain = cave[downAndRight, default: .air]
      if terrain == .air {
        sandLoc = downAndRight
        continue
      }

      cave[sandLoc] = .sand
      break
    }

    return false
  }

  func dropSand2(cave: inout [Location: Terrain], finalRow: Int) -> Bool {
    var sandLoc = Location(row: 0, col: 500)
    let startingTerrain = cave[sandLoc, default: .air]
    if startingTerrain == .sand {
      return true
    }

    while true {
      let nextDown = Location(row: sandLoc.row + 1, col: sandLoc.col)
      var terrain = cave[nextDown, default: .air]

      if terrain == .air && nextDown.row < finalRow + 2 {
        sandLoc = nextDown
        continue
      }

      let downAndLeft = Location(row: sandLoc.row + 1, col: sandLoc.col - 1)
      terrain = cave[downAndLeft, default: .air]
      if terrain == .air && downAndLeft.row < finalRow + 2 {
        sandLoc = downAndLeft
        continue
      }

      let downAndRight = Location(row: sandLoc.row + 1, col: sandLoc.col + 1)
      terrain = cave[downAndRight, default: .air]
      if terrain == .air && downAndRight.row < finalRow + 2 {
        sandLoc = downAndRight
        continue
      }

      cave[sandLoc] = .sand
      break
    }

    return false
  }

  func printCave(_ cave: [Location: Terrain]) {
    let startRow = cave.keys.reduce(9999) { partialResult, loc in
      min(partialResult, loc.row)
    }
    let startCol = cave.keys.reduce(9999) { partialResult, loc in
      min(partialResult, loc.col)
    }
    let endRow = cave.keys.reduce(0) { partialResult, loc in
      max(partialResult, loc.row)
    }
    let endCol = cave.keys.reduce(0) { partialResult, loc in
      max(partialResult, loc.col)
    }

    print()
    for r in startRow ... endRow {
      var str = ""
      for c in startCol - 1 ... endCol + 1 {
        let loc = Location(row: r, col: c)
        let terrain = cave[loc, default: .air]
        str += terrain.rawValue
      }
      print(str)
    }
    print()
  }
  
  enum Terrain: String {
    case air = "."
    case rock = "#"
    case sand = "o"
  }
}
