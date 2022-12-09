//  day09.swift - AoC 2021

import Foundation

func day09(testData: [String], realData: [String]) {
  // let expectedTestResults = 13    // Part 1
  let expectedTestResults = 1    // Part 2

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
    var headLoc = Location(row: 0, col: 0)
    var tailLoc = Location(row: 0, col: 0)
    var visitedLocs: Set<Location> = [tailLoc]

    //    for line in data {
    //      let parts = line.components(separatedBy: " ")
    //      let direction = parts[0]
    //      let steps = Int(parts[1]) ?? 0
    //
    //      for _ in 0 ..< steps {
    //        switch direction {
    //        case "R":
    //          headLoc.col += 1
    //        case "L":
    //          headLoc.col -= 1
    //        case "U":
    //          headLoc.row -= 1
    //        case "D":
    //          headLoc.row += 1
    //        default:
    //          break
    //        }
    //
    //        tailLoc = newTailLoc(head: headLoc, tail: tailLoc)
    //        visitedLocs.insert(tailLoc)
    //      }
    //    }
    //
    //    for v in visitedLocs {
    //      print(v)
    //    }
    //
    //    return visitedLocs.count   // Part 1: 6181


    var tailLocs = [
      1: tailLoc, 2: tailLoc, 3: tailLoc, 4: tailLoc, 5: tailLoc, 6: tailLoc, 7: tailLoc, 8: tailLoc, 9: tailLoc
    ]

    for line in data {
      let parts = line.components(separatedBy: " ")
      let direction = parts[0]
      let steps = Int(parts[1]) ?? 0

      for _ in 0 ..< steps {
        switch direction {
        case "R":
          headLoc.col += 1
        case "L":
          headLoc.col -= 1
        case "U":
          headLoc.row -= 1
        case "D":
          headLoc.row += 1
        default:
          break
        }

        tailLocs[1] = newTailLoc(head: headLoc, tail: tailLocs[1]!)
        for index in 2 ... 9 {
          tailLocs[index] = newTailLoc(head: tailLocs[index - 1]!, tail: tailLocs[index]!)
        }
        visitedLocs.insert(tailLocs[9]!)
      }
    }

    return visitedLocs.count   // Part 2: 2386
  }

  func newTailLoc(head: Location, tail: Location) -> Location {
    let rowDist = head.row - tail.row
    let colDist = head.col - tail.col

    if abs(rowDist) < 2 && abs(colDist) < 2 {
      return tail
    }

    if rowDist == 0 {
      if head.col < tail.col {
        return Location(row: tail.row, col: tail.col - 1)
      } else {
        return Location(row: tail.row, col: tail.col + 1)
      }
    } else if colDist == 0 {
      if head.row < tail.row {
        return Location(row: tail.row - 1, col: tail.col)
      } else {
        return Location(row: tail.row + 1, col: tail.col)
      }
    } else if rowDist < 0 && colDist < 0 {
      return Location(row: tail.row - 1, col: tail.col - 1)
    } else if rowDist < 0 && colDist > 0 {
      return Location(row: tail.row - 1, col: tail.col + 1)
    } else if rowDist > 0 && colDist < 0 {
      return Location(row: tail.row + 1, col: tail.col - 1)
    } else if rowDist > 0 && colDist > 0 {
      return Location(row: tail.row + 1, col: tail.col + 1)
    }

    return tail
  }
}
