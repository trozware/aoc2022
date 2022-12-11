//  day11.swift - AoC 2021

import Foundation

func day11(testData: [String], realData: [String]) {
  // let expectedTestResults = 10605    // Part 1
  let expectedTestResults = 2713310158    // Part 2

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
    var monkeys: [Monkey] = []

    for startLine in stride(from: 0, to: data.count, by: 7) {
     let monkeyData = Array(data[startLine ..< startLine + 6])
      let monkey = Monkey(lines: monkeyData)
      monkeys.append(monkey)
    }
    printMonkeys(monkeys)

    let product = Int(monkeys.reduce(1) { $0 * $1.testDivider})

    // Part 1: loop 20 times, Part 2: loop 10_000 times
    for _ in 1 ... 10_000 {
      for monkey in monkeys {
        for item in monkey.items {
          // Part 1: divideWorryBy is 3, Part 2: divideWorryBy is 0
          let (newItem, destination) = monkey.valueAndDestinationForItem(item, divideWorryBy: 0, mod: product)
          monkeys[destination].items.append(newItem)
        }
        monkey.items = []
      }
      // printMonkeys(monkeys)
    }

    printMonkeys(monkeys)

    var inspections = monkeys.map {
      $0.inspections
    }

    inspections.sort()
    inspections.reverse()
    let business = inspections[0] * inspections[1]

    // Part 1: 51075
    // Part 2: 11741456163

    return business
  }

  func printMonkeys(_ monkeys: [Monkey]) {
    for monkey in monkeys {
      print(monkey)
    }
    print()
  }

  class Monkey: CustomStringConvertible {
    let id: Int
    var items: [Int]
    var op: String
    var opNumber: Int
    var testDivider: Double
    var trueMonkey: Int
    var falseMonkey: Int
    var inspections = 0

    init(lines: [String]) {
      id = Int(lines[0].suffix(2).prefix(1)) ?? 0

      items = substring(of: lines[1], from: 18, upto: lines[1].count)
        .components(separatedBy: ", ")
        .compactMap(Int.init)

      let opWords = lines[2]
        .trimmingCharacters(in: .whitespaces)
        .components(separatedBy: " ")
      op = opWords[4]
      let num = opWords[5]
      if num == "old" {
        op = "sq"
        opNumber = 0
      } else {
        opNumber = Int(num) ?? 0
      }

      let testWords = lines[3]
        .trimmingCharacters(in: .whitespaces)
        .components(separatedBy: " ")
      testDivider = Double(testWords[3]) ?? 1

      let trueWords = lines[4]
        .trimmingCharacters(in: .whitespaces)
        .components(separatedBy: " ")
      trueMonkey = Int(trueWords[5]) ?? 0

      let falseWords = lines[5]
        .trimmingCharacters(in: .whitespaces)
        .components(separatedBy: " ")
      falseMonkey = Int(falseWords[5]) ?? 0
    }

    func valueAndDestinationForItem(_ item: Int, divideWorryBy: Int, mod: Int) -> (Int, Int) {
      inspections += 1

      var newItem = item
      if op == "sq" {
        newItem = item * item
      } else if op == "+" {
        newItem = item + opNumber
      } else if op == "*" {
        newItem = item * opNumber
      }

      if divideWorryBy == 0 {
        // Part 2
        newItem = newItem % mod
      } else {
        // Part 1
        newItem /= divideWorryBy
      }

      let remainder = Double(newItem).truncatingRemainder(dividingBy: testDivider)
      if remainder == 0 {
        return (newItem, trueMonkey)
      }

      return (newItem, falseMonkey)
    }

    var description: String {
      "id: \(id): inspections: \(inspections), items: \(items)"
    }
  }
}
