//  day01.swift - AoC 2021

import Foundation

func day01(testData: [String], realData: [String]) {
  // let expectedTestResults = 24000   // Part 1
  let expectedTestResults = 45000   // Part 2

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
    var elfNumber = 0
    var caloriesPerElf: [Int] = [0]

    for line in data {
      if line.isEmpty {
        elfNumber += 1
        caloriesPerElf.append(0)
      } else {
        let calories = Int(line) ?? 0
        caloriesPerElf[elfNumber] += calories
      }
    }

    caloriesPerElf.sort()
    caloriesPerElf.reverse()

    // Part 1
    // let maxCalories = caloriesPerElf[0]
    // return maxCalories  // 67016

    // Part 2
    let topThree = caloriesPerElf[0] + caloriesPerElf[1] + caloriesPerElf[2]
    return topThree   // 200116
  }
}
