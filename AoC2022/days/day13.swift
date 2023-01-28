//  day13.swift - AoC 2021

import Foundation

func day13(testData: [String], realData: [String]) {
  // let expectedTestResults = 13    // Part 1
  let expectedTestResults = 140    // Part 2

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
    // Part 1
    //
    //    var correctIndexSum = 0
    //    var pairNum = 0
    //
    //    for lineNum in stride(from: 0, to: data.count, by: 3) {
    //      let lhs = data[lineNum]
    //      let rhs = data[lineNum + 1]
    //      pairNum += 1
    //
    //      let lhsJson = convertStringToArray(str: lhs)
    //      let rhsJson = convertStringToArray(str: rhs)
    //
    //      let result = arraysAreSorted(lhs: lhsJson, rhs: rhsJson)
    //      print(lhs, rhs, result.rawValue)
    //      if result == .ordered {
    //        correctIndexSum += pairNum
    //      }
    //    }
    //
    //    return correctIndexSum     // Part 1: 6187

    // Part 2
    //

    let div1 = "[[2]]"
    let div2 = "[[6]]"

    var packets = data.filter { !$0.isEmpty }
    packets += [div1, div2]

    packets.sort { lhs, rhs in
      let lhsJson = convertStringToArray(str: lhs)
      let rhsJson = convertStringToArray(str: rhs)
      let result = arraysAreSorted(lhs: lhsJson, rhs: rhsJson)
      return result == .ordered
    }

    let index1 = packets.firstIndex(of: div1)
    let index2 = packets.firstIndex(of: div2)

    if let index1, let index2 {
      return (index1 + 1) * (index2 + 1)     // Part 2: 23520
    }

    return 0
  }

  func convertStringToArray(str: String) -> [Any] {
    if let json = try? JSONSerialization.jsonObject(with: Data(str.utf8)) {
      if let jsonArray = json as? [Any] {
        return jsonArray
      }
    }
    return []
  }

  func arraysAreSorted(lhs: Any, rhs: Any) -> Order {
    // can be Int or [Any]

    if let lhsInt = lhs as? Int, let rhsInt = rhs as? Int {
      if lhsInt < rhsInt {
        return .ordered
      } else if lhsInt > rhsInt {
        return .unordered
      }
      return .equal
    }

    if let lhsInt = lhs as? Int {
      return arraysAreSorted(lhs: [lhsInt], rhs: rhs)
    }

    if let rhsInt = rhs as? Int {
      return arraysAreSorted(lhs: lhs, rhs: [rhsInt])
    }

    if let lhsArr = lhs as? [Any], let rhsArr = rhs as? [Any] {
      let maxIndex = max(lhsArr.count, rhsArr.count)

      for index in 0 ..< maxIndex {
        if index >= lhsArr.count {
          return .ordered
        }
        if index >= rhsArr.count {
          return .unordered
        }

        let result = arraysAreSorted(lhs: lhsArr[index], rhs: rhsArr[index])
        if result != .equal {
          return result
        }
      }
    }

//    for index in 0 ..< lha.count {
//      if index >= rha.count {
//        return false
//      }
//
//      if lha[index] < rha[index] {
//        return true
//      } else if lha[index] > rha[index] {
//        return false
//      }
//    }
//
//    return true

    return .equal
  }
}

enum Order: String {
  case unordered, equal, ordered
}
