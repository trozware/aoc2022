//  day03.swift - AoC 2021

import Foundation

func day03(testData: [String], realData: [String]) {
  // let expectedTestResults = 157      // Part 1
  let expectedTestResults = 70      // Part 2

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
    var total: Int = 0

    // Part 1
    //
    //    for line in data {
    //      let chars = line.map { Character(extendedGraphemeClusterLiteral: $0) }
    //      let numChars = chars.count
    //      let halfChars = numChars / 2
    //
    //      let set1 = Set(Array(chars[0 ..< halfChars]))
    //      let set2 = Set(Array(chars[halfChars ..< numChars]))
    //
    //      if let common = set1.intersection(set2).first {
    //        let value = value(for: common)
    //        total += Int(value)
    //      }
    //    }

    // Part 2
    //
    for lineNum in stride(from: 0, to: data.count, by: 3) {
      let elf1 = Set(data[lineNum].map { Character(extendedGraphemeClusterLiteral: $0) })
      let elf2 = Set(data[lineNum + 1].map { Character(extendedGraphemeClusterLiteral: $0) })
      let elf3 = Set(data[lineNum + 2].map { Character(extendedGraphemeClusterLiteral: $0) })

      let common2 = elf1.intersection(elf2)
      let common3 = common2.intersection(elf3)

      if let common = common3.first {
        let value = value(for: common)
        total += Int(value)
      }
    }

    return total

    // Part 1: 7766
    // Part 2: 2415
  }

  func value(for letter: Character) -> UInt8 {
    guard let ascii = letter.asciiValue else {
      return 0
    }

    if ascii >= 97 && ascii <= 122 {
      return ascii - 96
    }

    if ascii >= 65 && ascii <= 90 {
      return ascii - 38
    }

    return 0
  }
}

