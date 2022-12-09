//  day07.swift - AoC 2021

import Foundation

func day07(testData: [String], realData: [String]) {
  // let expectedTestResults = 95437    // Part 1
  let expectedTestResults = 24933642    // Part 2

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
    let rootDir = Directory(name: "/")
    var currentDir: Directory = rootDir
    var allDirs: [Directory] = [rootDir]

    for line in data {
      if line == "$ ls" {
        continue
      }

      if line.hasPrefix("$ cd") {
        let dirName = substring(of: line, from: 5, upto: line.count)
        if dirName == currentDir.name {
          continue
        }
        if dirName == "..", let parent = currentDir.parent {
          currentDir = parent
        } else if dirName == "/" {
          currentDir = rootDir
        } else {
          let existingDir = currentDir.directories.first { $0.name == dirName }
          if let existingDir {
            currentDir = existingDir
          } else {
            let newDir = Directory(name: dirName)
            newDir.parent = currentDir
            currentDir.directories.append(newDir)
            currentDir = newDir
            allDirs.append(newDir)
          }
        }
      } else if line.hasPrefix("dir") {
        let dirName = substring(of: line, from: 4, upto: line.count)
        let newDir = Directory(name: dirName)
        newDir.parent = currentDir
        currentDir.directories.append(newDir)
        allDirs.append(newDir)
      } else {
        let parts = line.components(separatedBy: " ")
        let newFile = File(name: parts[1], size: Int(parts[0]) ?? 0)
        currentDir.files.append(newFile)
      }
    }

    //    print(rootDir)
    //    print()

    // Part 1
    //
    //    var smallDirSize = 0
    //    for dir in allDirs {
    //      let size = dir.size
    //      if size <= 100_000 {
    //        smallDirSize += size
    //      }
    //    }
    //
    //    return smallDirSize   // Part 1: 1908462

    // Part 2
    //
    let totalSpace = 70_000_000
    let requiredSpace = 30_000_000

    let freeSpace = totalSpace - rootDir.size
    let spaceToDelete = requiredSpace - freeSpace
    print(spaceToDelete)

    var bytes: [Int] = []
    for dir in allDirs {
      let size = dir.size
      if size >= spaceToDelete {
        bytes.append(size)
      }
    }

    bytes.sort()
    print(bytes)

    return bytes[0]   // Part 2: 3979145
  }

  class Directory: CustomStringConvertible {
    let name: String
    var files: [File] = []
    var directories: [Directory] = []
    var parent: Directory?

    init(name: String) {
      self.name = name
    }

    var size: Int {
      var fileSizes = files.reduce(0) { $0 + $1.size }

      for d in directories {
        fileSizes += d.size
      }

      return fileSizes
    }

    // for debug printing
    var description: String {
      var desc = "\(name):"
      desc += "\nDirs:"
      for directory in directories {
        desc += "\n\t\(directory.name)"
      }
      desc += "\nFiles:"
      for file in files {
        desc += "\n\t\(file.description)"
      }

      for dir in directories {
        desc += "\n\(dir.description)"
      }
      return desc
    }
  }

  struct File: CustomStringConvertible {
    let name: String
    let size: Int

    // for debug printing
    var description: String {
      "\(name) - \(size)"
    }
  }
}
