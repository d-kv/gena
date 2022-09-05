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
    //spec.static_framework = true (попробовать и тру и фолсе)
    // добавить appspec в основную подспеку, добавить для неё appDelegate
    // 
    mutating func run() throws {
        let lol = FileCreator()
            
        for i in 0 ..< 100 {
            do_magic(targets: 0,
                     classTarget: 0,
                     classFuncTarget: 0,
                     structsTarget: 0,
                     structsFuncTarget: 0,
                     classes: i*10,
                     classesFunc: 10,
                     structs: 1000 - i*10,
                     structsFunc: 10)
            print(i, "lol")
        }
        
        var ans = ""
        for i in output {
            ans += i.joined(separator: ",") + "\n"
        }
        lol.createFile(name: "results",
                       type: "csv",
                       path: URL(string: "file:///tmp/gena/"), data: ans)

        
    }

    mutating func do_magic(targets: Int, classTarget: Int, classFuncTarget: Int, structsTarget: Int, structsFuncTarget: Int, classes: Int, classesFunc: Int, structs: Int, structsFunc: Int) {
        do {
            try print(safeShell("(cd /Users/runner/work/gena/gena && swift run SpencilTry lexar pop 1 --classes \(classes) --classes-func \(classesFunc) --structs \(structs) --structs-func \(structsFunc) --pack-count \(targets) --target-classes \(classTarget) --target-classes-func \(classFuncTarget) --target-structs \(structsTarget) --target-structs-func \(structsFuncTarget) )"))
            let anns = [targets, classTarget, classFuncTarget, structsTarget, structsFuncTarget, classes, classesFunc, structs, structsFunc].map(String.init) + parce_ans(strShit: try safeShell("(cd /tmp/gena/pop && ulimit -n 65536 && start=$(date +%s) && time swift build && finish=$(date +%s) && printf \"|$start-=$finish|\")"))
            output.append(anns)
            try print(safeShell("(cd /tmp/gena && rm -rf pop)"))
        } catch {
            print("\(error)") // handle or silence the error here
        }
    }

    mutating func do_magic_cocoa(targets: Int, classTarget: Int, classFuncTarget: Int, structsTarget: Int, structsFuncTarget: Int, classes: Int, classesFunc: Int, structs: Int, structsFunc: Int) {
        do {
            try print(safeShell("(cd /Users/runner/work/gena/gena && swift run SpencilTry lexar pop 2 --classes \(classes) --classes-func \(classesFunc) --structs \(structs) --structs-func \(structsFunc) --pack-count \(targets) --target-classes \(classTarget) --target-classes-func \(classFuncTarget) --target-structs \(structsTarget) --target-structs-func \(structsFuncTarget) )"))
            let anns = [targets, classTarget, classFuncTarget, structsTarget, structsFuncTarget, classes, classesFunc, structs, structsFunc].map(String.init) + parce_ans(strShit: try safeShell("(cd /tmp/gena/pop && ulimit -n 65536 && xcodegen && pod install && start=$(date +%s) && xcodebuild && finish=$(date +%s) && printf \"|$start-=$finish|\")"))
            output.append(anns)
            try print(safeShell("(cd /tmp/gena && rm -rf pop)"))
        } catch {
            print("\(error)") // handle or silence the error here
        }
    }

    func parce_ans(strShit: String) -> [String] {
        var strSht = strShit
        print(strSht)
        if let i = strSht.firstIndex(of: "|") {
            let index: Int = strSht.distance(from: strSht.startIndex, to: i)
            strSht.removeFirst(index)
            strSht.replaceSubrange(strSht.range(of: "|")!, with: "")
            if let i = strSht.firstIndex(of: "|") {
                strSht.remove(at: i)
            }
        }
        strSht.replaceSubrange(strSht.range(of: "-=")!, with: ",")
        var str = strSht.split(separator: ",").map(String.init)
        print(str)
        let a =  String(Int(str[1])! - Int(str[0])!)
        return [a]
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
