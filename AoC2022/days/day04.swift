//  day04.swift - AoC 2021

import Foundation

func day04(testData: [String], realData: [String]) {
  // let expectedTestResults = 2        // Part 1
  let expectedTestResults = 4        // Part 2

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
    var overlaps = 0

    for line in data {
      let pairs = line.components(separatedBy: ",")
      if pairs.count != 2 {
        continue
      }

      let range1 = pairs[0].components(separatedBy: "-")
      let range2 = pairs[1].components(separatedBy: "-")

      guard
        let start1 = Int(range1[0]),
        let end1 = Int(range1[1]),
        let start2 = Int(range2[0]),
        let end2 = Int(range2[1]) else {
        continue
      }

      let set1 = Set(start1 ... end1)
      let set2 = Set(start2 ... end2)

      // Part 1
      //      if set1.isSubset(of: set2) || set2.isSubset(of: set1) {
      //        overlaps += 1
      //      }

      // Part 2
      if !set1.intersection(set2).isEmpty || !set2.intersection(set1).isEmpty {
        overlaps += 1
      }
    }

    return overlaps
    // Part 1: 483
    // Part 2: 874
  }
}
