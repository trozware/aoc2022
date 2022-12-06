//  day06.swift - AoC 2021

import Foundation

func day06(testData: [String], realData: [String]) {
  // let expectedTestResults = [7, 5, 6, 10, 11]   // Part 1
  let expectedTestResults = [19, 23, 23, 29, 26]   // Part 2

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

  func runCode(data: [String]) -> [Int] {
    var results: [Int] = []

    // let headerLength = 4   // Part 1
    let headerLength = 14   // Part 2

    for message in data {

      var testChars: [Character] = []
      var index = 0

      for char in message {
        index += 1
        testChars.append(char)

        while testChars.count > headerLength {
          testChars = Array(testChars.dropFirst(1))
        }

        let testSet = Set(testChars)
        if testSet.count == headerLength {
          break
        }
      }

      results.append(index)
    }

    return results

    // Part 1: 1757
    // Part 2: 2950
  }
}
