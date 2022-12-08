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

      // totalScore += calcTotalscore1(elfMove, yourMove)  // Part 1: 13052
      totalScore += calcTotalscore2(elfMove, yourMove)  // Part 2: 13693
    }

    return totalScore
  }

  func calcTotalscore1(_ elf: String, _ you: String) -> Int {
    let elfGame = Game.create(from: elf)

    let yourGame = Game.create(from: you)
    let yourScore = yourGame.rawValue

    let gameResult = GameResult.result(elf: elfGame, you: yourGame)
    let gameScore = gameResult.rawValue

    return gameScore + yourScore
  }

  func calcTotalscore2(_ elf: String, _ result: String) -> Int {
    let elfGame = Game.create(from: elf)

    let gameResult = GameResult.create(from: result)
    let gameScore = gameResult.rawValue

    let yourGame = elfGame.move(for: gameResult)
    let yourScore = yourGame.rawValue

    return gameScore + yourScore
  }

  enum Game: Int {
    case Rock = 1
    case Paper
    case Scissors

    static func create(from char: String) -> Game {
      switch char {
      case "A", "X":
        return .Rock
      case "B", "Y":
        return .Paper
      default:
        return .Scissors
      }
    }

    func winningMove() -> Game {
      switch self {
      case .Rock:
        return .Paper
      case .Paper:
        return .Scissors
      case .Scissors:
        return .Rock
      }
    }

    func losingMove() -> Game {
      switch self {
      case .Rock:
        return .Scissors
      case .Paper:
        return .Rock
      case .Scissors:
        return .Paper
      }
    }

    func move(for gameResult: GameResult) -> Game {
      switch gameResult {
      case .win:
        return winningMove()
      case .loss:
        return losingMove()
      case .draw:
        return self
      }
    }
  }

  enum GameResult: Int {
    case win = 6
    case loss = 0
    case draw = 3

    static func result(elf: Game, you: Game) -> GameResult {
      if elf == you {
        return .draw
      }
      if you == elf.winningMove() {
        return .win
      }
      return .loss
    }

    static func create(from char: String) -> GameResult {
      switch char {
      case "X":
        return .loss
      case "Y":
        return .draw
      default:
        return .win
      }
    }
  }
}
