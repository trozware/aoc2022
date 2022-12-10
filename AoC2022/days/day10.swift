//  day10.swift - AoC 2021

import Foundation

func day10(testData: [String], realData: [String]) {
  // let expectedTestResults = 13140    // Part 1
  let expectedTestResults = 0    // Part 2

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
    var registerX = 1
    var cycleCounter = 1
    var registerValues: [Int: Int] = [1: registerX]

    for line in data {
      if line == "noop" {
        registerValues[cycleCounter] = registerX
        cycleCounter += 1
      } else if line.hasPrefix("addx") {
        let addValue = Int(line.components(separatedBy: " ")[1]) ?? 0
        registerValues[cycleCounter] = registerX
        cycleCounter += 1
        registerX += addValue
        registerValues[cycleCounter] = registerX
        cycleCounter += 1
      }
    }

//    var signalStrengths = 0
//    for index in stride(from: 20, through: 220, by: 40) {
//      print(index, registerValues[index - 1]!, index * registerValues[index - 1]!)
//      signalStrengths += index * registerValues[index - 1]!
//    }
//
//    return signalStrengths  ]] Part 1: 15360

    var row: [String] = []
    var spritePos = 1
    var startOffset = 0

    for drawLine in 0 ..< 6 {
      row = Array(repeating: ".", count: 40)
      //      row[0] = "#"
      spritePos = 1
      startOffset = drawLine * 40

      for index in 2 ... 40 {
        if index >= spritePos && index <= spritePos + 2 {
          row[index - 1] = "#"
        }
        let move = registerValues[index + startOffset]!
        spritePos = move
      }
      print(row.joined(separator: " "))
    }

    // Part 2: PHLHJGZA

    return 0
  }
}

// ...............###......................

// # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # .

