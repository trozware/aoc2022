//  day12.swift - AoC 2021

import Foundation

func day12(testData: [String], realData: [String]) {
  let expectedTestResults = 31    // Part 1
  // let expectedTestResults = [1, 2]    // Part 2

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
    var heightMap: [Location: Int] = [:]
    var originalYou = Location(row: 0, col: 0)
    var goal = Location(row: 0, col: 0)

    for rowNum in 0 ..< data.count {
      let row = data[rowNum].map { Character(extendedGraphemeClusterLiteral: $0) }
      for colNum in 0 ..< row.count {
        let loc = Location(row: rowNum, col: colNum)
        var height = row[colNum]
        if height == "S" {
          originalYou = loc
          height = "a"
        } else if height == "E" {
          goal = loc
          height = "z"
        }
        heightMap[loc] = Int(height.asciiValue!) - 97
      }
    }

    var pendingPaths: [[Location]] = [[originalYou]]
    var completePaths: [[Location]] = []
    var badPaths: [[Location]] = []
    var bestResult = data.count * data[0].count

    while !pendingPaths.isEmpty {
      // print(pendingPaths.count)
      let path = pendingPaths[0]
      pendingPaths.removeFirst()

      let lastStep = path.last!

      let toLeft = Location(row: lastStep.row, col: lastStep.col - 1)
      let toRight = Location(row: lastStep.row, col: lastStep.col + 1)
      let toTop = Location(row: lastStep.row - 1, col: lastStep.col)
      let toBottom = Location(row: lastStep.row + 1, col: lastStep.col)

      let currentHeight = heightMap[lastStep]!

      let possibles = [toLeft, toRight, toTop, toBottom].filter {
        if let height = heightMap[$0],
           height <= currentHeight + 1
            && !path.contains($0) {
          return true
        }
        return false
      }

      if possibles.isEmpty {
        badPaths.append(path)
        continue
      }

      var possiblesByDistance: [Location: Int] = [:]
      var minDistance = Int.max

      for possible in possibles {
        let rowDist = abs(possible.row - goal.row)
        let colDist = abs(possible.col - goal.col)
        let heightDist = abs(heightMap[possible]! - heightMap[goal]!)
        let totalDist = rowDist + colDist + heightDist
        possiblesByDistance[possible] = totalDist
        if totalDist < minDistance {
          minDistance = totalDist
        }
      }

      var shortestPossibles: [Location] = []
      for (possible, dist) in possiblesByDistance {
        if dist == minDistance {
          shortestPossibles.append(possible)
        }
      }

      for possible in shortestPossibles {
        var newPath: [Location] = path
        newPath.append(possible)

        if possible == goal {
          completePaths.append(path)
          if path.count < bestResult {
            bestResult = path.count
          }
        } else if newPath.count <= bestResult {
          pendingPaths.append(newPath)
        }
      }
    }

//    for path in completePaths {
//      print(path.count)
//    }
//
//    for p in completePaths[0] {
//      print(p)
//    }

    print(bestResult)

    return bestResult

    // not 1228 or 1184
    // 7339 too high
  }
}


//    var stepCounts: [Int] = []
//
//    for _ in 0 ..< data[0].count {
//      var steps: [Location] = []
//      var blacklist: [Location] = []
//      var you = originalYou
//
//      while you != goal {
//        // print(you)
//
//        let toLeft = Location(row: you.row, col: you.col - 1)
//        let toRight = Location(row: you.row, col: you.col + 1)
//        let toTop = Location(row: you.row - 1, col: you.col)
//        let toBottom = Location(row: you.row + 1, col: you.col)
//
//        let yourHeight = heightMap[you]!
//
//        let possibles = [toLeft, toRight, toTop, toBottom].filter {
//          if let height = heightMap[$0],
//             height <= yourHeight + 1
//              && !steps.contains($0)
//              && !blacklist.contains($0) {
//            return true
//          }
//          return false
//        }
//
//        if possibles.count == 0 {
//          blacklist.append(steps.last!)
//          steps.removeLast()
//          you = steps.last!
//        } else if possibles.count == 1 {
//          steps.append(possibles[0])
//          you = possibles[0]
//        } else {
//          // prefer to go up than down
//          let sortedSteps = possibles.sorted { loc1, loc2 in
//            heightMap[loc2]! < heightMap[loc1]!
//          }
//
//          // extract just the highest
//          let highestJump = heightMap[sortedSteps[0]]!
//          let highestSteps = sortedSteps.filter {
//            heightMap[$0]! == highestJump
//          }
//
//          //          for s in highestSteps {
//          //            print(s, heightMap[s]!)
//          //          }
//
//          let step = highestSteps.randomElement()!
//          steps.append(step)
//          you = step
//        }
//      }
//
//      print(steps.count)
//      stepCounts.append(steps.count)
//    }
//
//    stepCounts.sort()
//    print(stepCounts)
//
//    return stepCounts[0]
