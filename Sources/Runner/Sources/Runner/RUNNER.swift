import ArgumentParser
import Foundation

@main
struct GenerateProject: ParsableCommand {
    @Argument(help: "Max Targets")
    var maxTargets: Int
    @Argument(help: "Max func count")
    var sumfunc: Int
    @Argument(help: "Max class count")
    var maxClass: Int
    let curr_directory = "/Users/runner/work/gena/"
    var output: [[String]] = [["targets", "targets_class", "targets_class_func", "targets_structs",
                               "targets_structs_func", "projects_class", "project_class_func", "project_structs",
                               "project_structs_func","timestamp"]]
    // снять таймстеп
    // вынести всё это в отдельную функцию
    // интервал больше( инверсия структур и классов)
    // весь код по кол-ву таргетов
    mutating func run() throws {
        let lol = FileCreator()
        // var target = 1
        // let structsum = 2048
        // for i in 0 ..< 12 {
        //     do_magic(targets: target - 1,
        //              classTarget: 0,
        //              classFuncTarget: 0,
        //              structsTarget: structsum / target,
        //              structsFuncTarget: 10,
        //              classes: 0,
        //              classesFunc: 0,
        //              structs: structsum / target,
        //              structsFunc: 10)
        //     target *= 2
        //     print(i)
        // }
        // for i in 0 ..< 101 {
        //     do_magic(targets: 0,
        //              classTarget: 0,
        //              classFuncTarget: 0,
        //              structsTarget: 0,
        //              structsFuncTarget: 0,
        //              classes: i,
        //              classesFunc: 300,
        //              structs: 100 - i,
        //              structsFunc: 300)
        //     print(i)
        // }
        // var ans = ""
        // for i in output {
        //     ans += i.joined(separator: ",") + "\n"
        // }
        // lol.createFile(name: "results",
        //                type: "csv",
        //                path: URL(string: "file:///home/lexar"), data: ans)

        // output = [["targets", "targets_class", "targets_class_func", "targets_structs",
        //                        "targets_structs_func", "projects_class", "project_class_func", "project_structs",
        //                        "project_structs_func","timestamp"]]
                       
        let structsum = 2105
        for i in 1 ..< 10 {
            do_magic(targets: i,
                     classTarget: 0,
                     classFuncTarget: 0,
                     structsTarget: (structsum - 105) /  i,
                     structsFuncTarget: 20,
                     classes: 0,
                     classesFunc: 0,
                     structs: 105,
                     structsFunc: 20)
            print(i, "lol")
        }
        
        var ans = ""
        for i in output {
            ans += i.joined(separator: ",") + "\n"
        }
        lol.createFile(name: "results",
                       type: "csv",
                       path: URL(string: "file://\(curr_directory)"), data: ans)

        // output = [["targets", "targets_class", "targets_class_func", "targets_structs",
        //                        "targets_structs_func", "projects_class", "project_class_func", "project_structs",
        //                        "project_structs_func","timestamp"]]
        // for i in 1 ..< 101 {
        //     do_magic(targets: i,
        //              classTarget: 0,
        //              classFuncTarget: 0,
        //              structsTarget: (structsum - 105) /  i,
        //              structsFuncTarget: 50,
        //              classes: 0,
        //              classesFunc: 0,
        //              structs: 105,
        //              structsFunc: 50)
        //     print(i, "lol")
        // }
        
        // ans = ""
        // for i in output {
        //     ans += i.joined(separator: ",") + "\n"
        // }
        // lol.createFile(name: "resultsTr50",
        //                type: "csv",
        //                path: URL(string: "file:///home/lexar"), data: ans)
        //     output = [["targets", "targets_class", "targets_class_func", "targets_structs",
        //                        "targets_structs_func", "projects_class", "project_class_func", "project_structs",
        //                        "project_structs_func","timestamp"]]
        // for i in 1 ..< 101 {
        //     do_magic(targets: i,
        //              classTarget: 0,
        //              classFuncTarget: 0,
        //              structsTarget: (structsum - 105) /  i,
        //              structsFuncTarget: 100,
        //              classes: 0,
        //              classesFunc: 0,
        //              structs: 105,
        //              structsFunc: 100)
        //     print(i, "lol")
        // }
        
        // ans = ""
        // for i in output {
        //     ans += i.joined(separator: ",") + "\n"
        // }
        // lol.createFile(name: "resultsTr100",
        //                type: "csv",
        //                path: URL(string: "file:///home/lexar"), data: ans)
    }

    mutating func do_magic(targets: Int, classTarget: Int, classFuncTarget: Int, structsTarget: Int, structsFuncTarget: Int, classes: Int, classesFunc: Int, structs: Int, structsFunc: Int) {
        do {
            try print(safeShell("(cd \(curr_directory)gena && swift run SpencilTry lexar pop 1 --classes \(classes) --classes-func \(classesFunc) --structs \(structs) --structs-func \(structsFunc) --pack-count \(targets) --target-classes \(classTarget) --target-classes-func \(classFuncTarget) --target-structs \(structsTarget) --target-structs-func \(structsFuncTarget) )"))
            let anns = [targets, classTarget, classFuncTarget, structsTarget, structsFuncTarget, classes, classesFunc, structs, structsFunc].map(String.init) + parce_ans(strShit: try safeShell("(cd /tmp/gena/pop && ulimit -n 65536 && start=$(date +%s) && time swift build && finish=$(date +%s) && printf \"$start-=$finish\")"))
            output.append(anns)
            try print(safeShell("(cd /tmp/gena && rm -rf pop)"))
        } catch {
            print("\(error)") // handle or silence the error here
        }
    }

    func parce_ans(strShit: String) -> [String] {
        var strSht = strShit
        print(strSht)
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
        strSht.replaceSubrange(strSht.range(of: "\n")!, with: "\",")
        strSht.replaceSubrange(strSht.range(of: "-=")!, with: ",")
        var str = strSht.split(separator: ",").map(String.init)
        print(str)
        str[7] = String(Int(str[8])! - Int(str[7])!)
        str.removeLast()
        return [str[7]]
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
