//  day12.swift - AoC 2021

import Foundation

func day12(testData: [String], realData: [String]) {
  // let expectedTestResults = 31    // Part 1
  let expectedTestResults = 29    // Part 2

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
    var you = Location(row: 0, col: 0)
    var goal = Location(row: 0, col: 0)

    for rowNum in 0 ..< data.count {
      let row = data[rowNum].map { Character(extendedGraphemeClusterLiteral: $0) }
      for colNum in 0 ..< row.count {
        let loc = Location(row: rowNum, col: colNum)
        var height = row[colNum]
        if height == "S" {
          you = loc
          height = "a"
        } else if height == "E" {
          goal = loc
          height = "z"
        }
        heightMap[loc] = Int(height.asciiValue!) - 97
      }
    }

    //    let path = shortestPath(from: you, to: goal, in: heightMap)
    //    return path

    // Part 1: 484


    let lowestHeight = heightMap[you]!
    var lowPoints:[Location] = []
    for (loc, height) in heightMap {
      if height == lowestHeight {
        lowPoints.append(loc)
      }
    }

    var shortPaths = lowPoints.map { loc in
      shortestPath(from: loc, to: goal, in: heightMap)
    }
    shortPaths.sort()

    return shortPaths[0]
  }

  func shortestPath(from start: Location, to goal: Location, in heightMap: [Location: Int]) -> Int {
    var shortestPath = Int.max

    var pathDistances: [Location: Int] = [start: 0]
    var locationsToCheck: [Location] = [start]

    while !locationsToCheck.isEmpty {
      // print(locationsToCheck.count)

      let location = locationsToCheck[0]
      locationsToCheck.removeFirst()

      let distance = pathDistances[location, default: 0]
      let currentHeight = heightMap[location]!

      let toLeft = Location(row: location.row, col: location.col - 1)
      let toRight = Location(row: location.row, col: location.col + 1)
      let toTop = Location(row: location.row - 1, col: location.col)
      let toBottom = Location(row: location.row + 1, col: location.col)

      let possibles = [toLeft, toRight, toTop, toBottom].filter {
        if let height = heightMap[$0],
           height <= currentHeight + 1 {
          return true
        }
        return false
      }

      for possible in possibles {
        if possible == goal {
          shortestPath = distance + 1
          locationsToCheck = []
          break
        }

        if let previousCheck = pathDistances[possible] {
          // is it longer than the current + 1
          if previousCheck > distance + 1 {
            pathDistances[possible] = distance + 1
          }
        } else {
          locationsToCheck.append(possible)
          pathDistances[possible] = distance + 1
        }
      }
    }

    return shortestPath
  }
}
