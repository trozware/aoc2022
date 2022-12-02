//  day02.swift - AoC 2021

import Foundation

func day02(testData: [String], realData: [String]) {
  // let expectedTestResults = 15    // Part 1
  let expectedTestResults = 12    // Part 2

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
    var totalScore = 0

    for line in data {
      let elfMove = line[0]
      let yourMove = line[2]

      // totalScore += gameResult1(elfMove, yourMove)
      totalScore += gameResult2(elfMove, yourMove)
    }

    return totalScore
  }

  func gameResult1(_ elf: String, _ you: String) -> Int {
    let elfPlays = ["A": "Rock", "B": "Paper", "C": "Scissors"]
    let yourPlays = ["X": "Rock", "Y": "Paper", "Z": "Scissors"]
    let yourPoints = ["X": 1, "Y": 2, "Z": 3]

    let elfChoice = elfPlays[elf]!
    let yourChoice = yourPlays[you]!
    let yourPoint = yourPoints[you]!

    if elfChoice == yourChoice {
      return 3 + yourPoint
    }

    if elfChoice == "Rock" {
      if yourChoice == "Paper" {
        return 6 + yourPoint
      } else if yourChoice == "Scissors" {
        return 0 + yourPoint
      }
    } else if elfChoice == "Paper" {
      if yourChoice == "Scissors" {
        return 6 + yourPoint
      } else if yourChoice == "Rock" {
        return 0 + yourPoint
      }
    } else if elfChoice == "Scissors" {
      if yourChoice == "Rock" {
        return 6 + yourPoint
      } else if yourChoice == "Paper" {
        return 0 + yourPoint
      }
    }

    return 3 + yourPoint
  }

  func gameResult2(_ elf: String, _ result: String) -> Int {
    let elfPlays = ["A": "Rock", "B": "Paper", "C": "Scissors"]
    let yourResults = ["X": "lose", "Y": "draw", "Z": "win"]
    let yourPoints = ["Rock": 1, "Paper": 2, "Scissors": 3]

    let elfChoice = elfPlays[elf]!
    let yourResult = yourResults[result]!

    if elfChoice == "Rock" {
      if yourResult == "win" {
        return 6 + yourPoints["Paper"]!
      } else if yourResult == "lose" {
        return 0 + yourPoints["Scissors"]!
      } else {
        return 3 + yourPoints["Rock"]!
      }
    } else if elfChoice == "Paper" {
      if yourResult == "win" {
        return 6 + yourPoints["Scissors"]!
      } else if yourResult == "lose" {
        return 0 + yourPoints["Rock"]!
      } else {
        return 3 + yourPoints["Paper"]!
      }
    } else if elfChoice == "Scissors" {
      if yourResult == "win" {
        return 6 + yourPoints["Rock"]!
      } else if yourResult == "lose" {
        return 0 + yourPoints["Paper"]!
      } else {
        return 3 + yourPoints["Scissors"]!
      }
    }

    return 0
  }
}
