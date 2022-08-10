import ArgumentParser
import Foundation
import SwiftCSV

@main
struct GenerateProject: ParsableCommand {
    @Argument(help: "Max Targets")
    var maxTargets: Int
    @Argument(help: "Max Classes in Targets")
    var maxClassTarget: Int
    @Argument(help: "Max Classes func in Targets")
    var maxClassFuncTarget: Int
    @Argument(help: "Max Structs in Targets")
    var maxStructsTarget: Int
    @Argument(help: "Max Structs func in Targets")
    var maxStructsFuncTarget: Int
    @Argument(help: "Max Number of classes in the project")
    var classes = 0
    @Argument(help: "Max Number of function in classes(default 10)")
    var classesFunc = 10
    @Argument(help: "Max Number of structs in the project")
    var structs = 0
    @Argument(help: "Max Number of function in structs(default 10)")
    var structsFunc = 10

    mutating func run() throws {
        let lol = FileCreator()
        var out = "targets,targets_class,targets_class_func,targets_structs,targets_structs_func,projects_class,project_class_func,project_structs,project_structs_func,build_complete,real_time,user_time,sys_time"
        lol.createFile(name: "results",
                       type: "csv",
                       path: URL(string: "file:///home/lexar"), data: "")
        for a in 0 ..< maxTargets {
            for b in 0 ..< maxClassTarget {
                for c in 0 ..< maxClassFuncTarget {
                    for d in 0 ..< maxStructsTarget {
                        for e in 0 ..< maxStructsFuncTarget {
                            for f in 0 ..< classes {
                                for g in 0 ..< classesFunc {
                                    for h in 0 ..< structs {
                                        for i in 0 ..< structsFunc {
                                            do {
                                                out += "\n\(a),\(b),\(c),\(d),\(e),\(f),\(g),\(h),\(i),"
                                                print("\n\(a),\(b),\(c),\(d),\(e),\(f),\(g),\(h),\(i),")
                                                var strSht = ""
                                                // снять таймстеп 
                                                //вынести всё это в отдельную функцию
                                                //интервал больше( инверсия структур и классов)
                                                //весь код по кол-ву таргетов
                                                try safeShell("(cd /home/lexar/projects/gena && swift run SpencilTry lexar pop 1 --classes \(f) --classes-func \(g) --structs \(h) --structs-func \(i) --pack-count \(a) --target-classes \(b) --target-classes-func \(c) --target-structs \(d) --target-structs-func \(e))")
                                                try strSht = safeShell("(cd /tmp/gena/pop && time swift build)")
                                                try safeShell("(cd /tmp/gena && rm -rf pop)")

                                                if let i = strSht.firstIndex(of: "(") {
                                                    let index: Int = strSht.distance(from: strSht.startIndex, to: i)
                                                    strSht.removeFirst(index)
                                                    strSht.replaceSubrange(strSht.range(of: "(")!, with: "\"")
                                                    if let i = strSht.firstIndex(of: ")") {
                                                        strSht.remove(at: i)
                                                    }
                                                }
                                                strSht.replaceSubrange(strSht.range(of: "\n\nreal\t")!, with: "\",\"")
                                                strSht.replaceSubrange(strSht.range(of: "\nuser\t")!, with: "\",\"")
                                                strSht.replaceSubrange(strSht.range(of: "\nsys\t")!, with: "\",\"")
                                                strSht.replaceSubrange(strSht.range(of: "\n")!, with: "\"")
                                                out += strSht
                                                // Error Domain=NSPOSIXErrorDomain Code=9 "Bad file descriptor"
                                                // Error Domain=NSPOSIXErrorDomain Code=9 "Bad file descriptor"
                                                // Error Domain=NSPOSIXErrorDomain Code=9 "Bad file descriptor"
                                                // Error Domain=NSPOSIXErrorDomain Code=9 "Bad file descriptor"
                                                // Error Domain=NSPOSIXErrorDomain Code=9 "Bad file descriptor"

                                            } catch {
                                                print("\(error)") // handle or silence the error here
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        try out.write(to: URL(string: "file:///home/lexar/results.csv")!, atomically: true, encoding: .utf8)
    }
}

func safeShell(_ command: String) throws -> String {
    let task = Process()
    let pipe = Pipe()

    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c", command]
    task.executableURL = URL(fileURLWithPath: "/bin/bash") // <--updated
    task.standardInput = nil

    try task.run() // <--updated

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!

    return output
}

class FileCreator {
    func createFile(name: String, type: String, path: URL?, data: String) {
        guard let fileURL = path?.appendingPathComponent(name).appendingPathExtension(type) else {
            fatalError("Not able to create URL")
        }

        // Writing to the file named Test
        do {
            try data.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            assertionFailure("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
        }
    }

    func createFolder(name: String, path: String) {
        let manager = FileManager()
        do {
            try manager.createDirectory(atPath: path + name, withIntermediateDirectories: true)
        } catch _ as NSError {
            print("Error while creating a folder.")
        }
    }
}

// Example usage:
// do {
// 	try print(safeShell("(cd /home/lexar/projects/gena && swift run SpencilTry lexar pop 1 --classes 10 --classes-func 50 --pack-count 20 --target-classes 10)"))
//     	try print(safeShell("(cd /tmp/gena/pop && swift build)"))

// }
// catch {
//     print("\(error)") //handle or silence the error here
// }
