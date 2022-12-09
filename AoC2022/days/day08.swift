//  day08.swift - AoC 2021

import Foundation

func day08(testData: [String], realData: [String]) {
  // let expectedTestResults = 21    // Part 1
  let expectedTestResults = 8    // Part 2

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
    var trees: [Location: Int] = [:]
    let totalRows = data.count
    let treesPerRow = data[0].count

    for rowNum in 0 ..< data.count {
      let row = data[rowNum]
      for colNum in 0 ..< treesPerRow {
        trees[Location(row: rowNum, col: colNum)] = Int(row[colNum])
      }
    }

    //    var visibleTrees = 0
    //    for (loc, height) in trees {
    //      let vis = isVisible(trees: trees, row: loc.row, col: loc.col, treeHeight: height, totalRows: totalRows, treesPerRow: treesPerRow)
    //      if vis {
    //        // print("Row: \(row), col: \(col), height: \(height)")
    //        visibleTrees += 1
    //      }
    //    }
    //
    //    return visibleTrees    // Part 1: 1801

    var maxScore = 0
    for (loc, height) in trees {
      let score = scenicScore(trees: trees, row: loc.row, col: loc.col, treeHeight: height, totalRows: totalRows, treesPerRow: treesPerRow)
      if score > maxScore {
        maxScore = score
      }
    }

    return maxScore    // Part 2: 209880
  }

  func isVisible(trees: [Location: Int], row: Int, col: Int, treeHeight: Int, totalRows: Int, treesPerRow: Int) -> Bool {
    if row == 0 || row == trees.count - 1 {
      return true
    }

    if col == 0 || col == treesPerRow - 1 {
      return true
    }

    // to the left
    var freeOnLeft = true
    for index in stride(from: col - 1, through: 0, by: -1) {
      if let nearTree = trees[Location(row: row, col: index)], nearTree >= treeHeight {
        freeOnLeft = false
        break
      }
    }
    if freeOnLeft {
      return true
    }

    // to the right
    var freeOnRight = true
    for index in stride(from: col + 1, to: treesPerRow, by: 1) {
      if let nearTree = trees[Location(row: row, col: index)], nearTree >= treeHeight {
        freeOnRight = false
        break
      }
    }
    if freeOnRight {
      return true
    }

    // to the top
    var freeOnTop = true
    for index in stride(from: row - 1, through: 0, by: -1) {
      if let nearTree = trees[Location(row: index, col: col)], nearTree >= treeHeight {
        freeOnTop = false
        break
      }
    }
    if freeOnTop {
      return true
    }

    // to the bottom
    var freeOnBottom = true
    for index in stride(from: row + 1, to: totalRows, by: 1) {
      if let nearTree = trees[Location(row: index, col: col)], nearTree >= treeHeight {
        freeOnBottom = false
        break
      }
    }
    if freeOnBottom {
      return true
    }

    return false
  }

  func scenicScore(trees: [Location: Int], row: Int, col: Int, treeHeight: Int, totalRows: Int, treesPerRow: Int) -> Int {
    // to the left
    var viewLeft = 0
    for index in stride(from: col - 1, through: 0, by: -1) {
      viewLeft += 1
      if let nearTree = trees[Location(row: row, col: index)], nearTree >= treeHeight {
        break
      }
    }

    // to the right
    var viewRight = 0
    for index in stride(from: col + 1, to: treesPerRow, by: 1) {
      viewRight += 1
      if let nearTree = trees[Location(row: row, col: index)], nearTree >= treeHeight {
        break
      }
    }

    // to the top
    var viewTop = 0
    for index in stride(from: row - 1, through: 0, by: -1) {
      viewTop += 1
      if let nearTree = trees[Location(row: index, col: col)], nearTree >= treeHeight {
        break
      }
    }

    // to the bottom
    var viewBottom = 0
    for index in stride(from: row + 1, to: totalRows, by: 1) {
      viewBottom += 1
      if let nearTree = trees[Location(row: index, col: col)], nearTree >= treeHeight {
        break
      }
    }

    let score = viewLeft * viewRight * viewTop * viewBottom
    return score
  }
}

struct Location: Equatable, Hashable {
  let row: Int
  let col: Int
}
