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

      // totalScore += gameResult1(elfMove, yourMove)  // Part 1: 13052
      totalScore += gameResult2(elfMove, yourMove)  // Part 1: 13693
    }

    return totalScore
  }

  func gameResult1(_ elf: String, _ you: String) -> Int {
    let elfPlays = ["A": "Rock", "B": "Paper", "C": "Scissors"]
    let yourPlays = ["X": "Rock", "Y": "Paper", "Z": "Scissors"]
    let yourPoints = ["Rock": 1, "Paper": 2, "Scissors": 3]
    let gameResults = [
      "Rock-Rock": 3,
      "Rock-Paper": 6,
      "Rock-Scissors": 0,
      "Paper-Rock": 0,
      "Paper-Paper": 3,
      "Paper-Scissors": 6,
      "Scissors-Rock": 6,
      "Scissors-Paper": 0,
      "Scissors-Scissors": 3
    ]

    let elfChoice = elfPlays[elf]!
    let yourChoice = yourPlays[you]!
    let yourPoint = yourPoints[yourChoice]!

    let game = "\(elfChoice)-\(yourChoice)"
    let result = gameResults[game]!

    return result + yourPoint
  }

  func gameResult2(_ elf: String, _ result: String) -> Int {
    let elfPlays = ["A": "Rock", "B": "Paper", "C": "Scissors"]
    let yourResults = ["X": "lose", "Y": "draw", "Z": "win"]
    let yourPoints = ["Rock": 1, "Paper": 2, "Scissors": 3]
    let gameResults = [
      "Rock-lose": "Scissors",
      "Rock-win": "Paper",
      "Rock-draw": "Rock",
      "Paper-lose": "Rock",
      "Paper-win": "Scissors",
      "Paper-draw": "Paper",
      "Scissors-lose": "Paper",
      "Scissors-win": "Rock",
      "Scissors-draw": "Scissors"
    ]
    let resultPoints = ["lose": 0, "draw": 3, "win": 6]

    let elfChoice = elfPlays[elf]!
    let yourResult = yourResults[result]!

    let game = "\(elfChoice)-\(yourResult)"
    let yourChoice = gameResults[game]!
    let yourPoint = yourPoints[yourChoice]!

    let score = yourPoint + resultPoints[yourResult]!
    return score
  }
}
