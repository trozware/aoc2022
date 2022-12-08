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
    var trees: [[Int]] = []

    for row in data {
      var rowData: [Int] = []
      for col in row {
        rowData.append(Int(String(col)) ?? 0)
      }
      trees.append(rowData)
    }

    // printTrees(trees)

    //    var visibleTrees = 0
    //    let treesPerRow = trees[0].count
    //    for row in 0 ..< trees.count {
    //      for col in 0 ..< treesPerRow {
    //        let vis = isVisible(trees: trees, rowIndex: row, colIndex: col)
    //        if vis {
    //          print("Row: \(row), col: \(col), height: \(trees[row][col])")
    //          visibleTrees += 1
    //        }
    //      }
    //      print()
    //    }
    //
    //    return visibleTrees    // Part 1: 1801

    var maxScore = 0
    let treesPerRow = trees[0].count
    for row in 0 ..< trees.count {
      for col in 0 ..< treesPerRow {
        let score = scenicScore(trees: trees, rowIndex: row, colIndex: col)
        if score > maxScore {
          maxScore = score
        }
      }
    }

    return maxScore    // Part 2; 209880
  }

  func printTrees(_ trees: [[Int]]) {
    for row in trees {
      var display = ""
      for col in row {
        display += "\(col) "
      }
      print(display)
    }
    print()
  }

  func isVisible(trees: [[Int]], rowIndex: Int, colIndex: Int) -> Bool {
    if rowIndex == 0 || rowIndex == trees.count - 1 {
      return true
    }

    let treesPerRow = trees[0].count
    if colIndex == 0 || colIndex == treesPerRow - 1 {
      return true
    }

    let treeHeight = trees[rowIndex][colIndex]
    // print("Tree height: \(treeHeight)")

    let row = trees[rowIndex]

    // to the left
    var freeOnLeft = true
    for index in stride(from: colIndex - 1, through: 0, by: -1) {
      if row[index] >= treeHeight {
        freeOnLeft = false
        break
      }
    }
    if freeOnLeft {
      return true
    }

    // to the right
    var freeOnRight = true
    for index in stride(from: colIndex + 1, to: treesPerRow, by: 1) {
      if row[index] >= treeHeight {
        freeOnRight = false
        break
      }
    }
    if freeOnRight {
      return true
    }

    // to the top
    var freeOnTop = true
    for index in stride(from: rowIndex - 1, through: 0, by: -1) {
      if trees[index][colIndex] >= treeHeight {
        freeOnTop = false
        break
      }
    }
    if freeOnTop {
      return true
    }

    // to the bottom
    var freeOnBottom = true
    for index in stride(from: rowIndex + 1, to: trees.count, by: 1) {
      if trees[index][colIndex] >= treeHeight {
        freeOnBottom = false
        break
      }
    }
    if freeOnBottom {
      return true
    }

    return false
  }

  func scenicScore(trees: [[Int]], rowIndex: Int, colIndex: Int) -> Int {
    let treeHeight = trees[rowIndex][colIndex]
    let treesPerRow = trees[0].count

    let row = trees[rowIndex]

    // to the left
    var viewLeft = 0
    for index in stride(from: colIndex - 1, through: 0, by: -1) {
      viewLeft += 1
      if row[index] >= treeHeight {
        break
      }
    }

    // to the right
    var viewRight = 0
    for index in stride(from: colIndex + 1, to: treesPerRow, by: 1) {
      viewRight += 1
      if row[index] >= treeHeight {
        break
      }
    }

    // to the top
    var viewTop = 0
    for index in stride(from: rowIndex - 1, through: 0, by: -1) {
      viewTop += 1
      if trees[index][colIndex] >= treeHeight {
        break
      }
    }

    // to the bottom
    var viewBottom = 0
    for index in stride(from: rowIndex + 1, to: trees.count, by: 1) {
      viewBottom += 1
      if trees[index][colIndex] >= treeHeight {
        break
      }
    }

    let score = viewLeft * viewRight * viewTop * viewBottom
    return score
  }
}
