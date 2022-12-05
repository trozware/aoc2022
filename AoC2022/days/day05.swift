//  day05.swift - AoC 2021

import Foundation

func day05(testData: [String], realData: [String]) {
  // let expectedTestResults = "CMZ"   // Part 1
  let expectedTestResults = "MCD"   // Part 2

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

  func runCode(data: [String]) -> String {
    var stackLines: [String] = []
    var instructionLines: [String] = []
    var intoInstructions = false

    for line in data {
      if line.isEmpty {
        intoInstructions = true
      } else if intoInstructions {
        instructionLines.append(line)
      } else {
        stackLines.append(line)
      }
    }

    let stackNumbers = stackLines
      .last!
      .components(separatedBy: .whitespaces)
      .compactMap(Int.init)

    stackLines = stackLines.dropLast(1).reversed()
    let stackLineLength = stackNumbers.count * 4 - 1

    var stacks: [Int: [String]] = [:]
    for number in stackNumbers {
      stacks[number] = []
    }

    for stackLine in stackLines {
      var stackIndex = 0
      for charNum in stride(from: 1, to: stackLineLength, by: 4) {
        stackIndex += 1
        let crate = stackLine[charNum]
        if !crate.isEmpty && crate != " " {
          stacks[stackIndex]?.append(crate)
        }
      }
    }

    // print(stacks)

    let instructions = instructionLines.map { Instruction(line: $0) }

    for instruction in instructions {
      // Part 1
      //  for _ in 0 ..< instruction.counter {
      //    if let mover = stacks[instruction.from]?.removeLast() {
      //      stacks[instruction.to]?.append(mover)
      //    }
      //  }

      // Part 2
      if let startStack = stacks[instruction.from], let endStack = stacks[instruction.to] {
        let movers = Array(startStack.suffix(instruction.counter))
        stacks[instruction.from] = startStack.dropLast(instruction.counter)
        stacks[instruction.to] = endStack + movers
      }

      // print(stacks)
    }

    // print(stacks)

    var result = ""
    for index in 1 ... stackNumbers.count {
      result += stacks[index]!.last!
    }

    return result
    // Part 1: JCMHLVGMG
    // Part 2: LVMRWSSPZ
  }

}

struct Instruction {
  let counter: Int
  let from: Int
  let to: Int

  init(line: String) {
    let words = line.components(separatedBy: " ")
    counter = Int(words[1]) ?? 0
    from = Int(words[3]) ?? 0
    to = Int(words[5]) ?? 0
  }
}
