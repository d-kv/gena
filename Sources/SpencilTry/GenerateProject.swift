import ArgumentParser
import Foundation
import Stencil

@main
struct GenerateProject: ParsableCommand {
    @Argument(help: "Your current user name")
    var userName: String
    @Argument(help: "Name of the project being created")
    var projectName: String
    @Argument(help: "Dependensies manager (spm - 1, cocoapods - 2)")
    var projectType: Int
    @Option(help: "Number of classes in the project")
    var classes = 0
    @Option(help: "Number of function in classes(default 10)")
    var classesFunc = 10
    @Option(help: "Number of structs in the project")
    var structs = 0
    @Option(help: "Number of function in structs(default 10)")
    var structsFunc = 10
    @Option(help: "Number of packages(default 0)")
    var packCount = 0
    @Option(help: "Number of classes in the project")
    var targetClasses = 0
    @Option(help: "Number of function in classes(default 10)")
    var targetClassesFunc = 10
    @Option(help: "Number of structs in the project")
    var targetStructs = 0
    @Option(help: "Number of function in structs(default 10)")
    var targetStructsFunc = 10

    mutating func run() throws {
        let _ = try ProjectCreator(name: projectName,
                                   username: userName,
                                   manager: projectType,
                                   target: true,
                                   fatherName: "",
                                   son_count: packCount)
        let lol_ = FileCreator()
        for i in 0 ..< classes {
            lol_.createFile(name: "Class_\(projectName)" + String(i),
                            type: "swift",
                            path: URL(string: "file:///tmp/gena/\(projectName)/Sources/\(projectName)/Classes/"),
                            data: try ClassCreator(countFunc: classesFunc, number: i, template: "class_template.html", name: "CLASS_\(projectName)").fileTemplate)
        }

        for i in 0 ..< structs {
            lol_.createFile(name: "Struct_\(projectName)" + String(i),
                            type: "swift",
                            path: URL(string: "file:///tmp/gena/\(projectName)/Sources/\(projectName)/Structs/"),
                            data: try ClassCreator(countFunc: structsFunc, number: i, template: "struct_template.html", name: "STRUCT_\(projectName)").fileTemplate)
        }

        for q in 0 ..< packCount {
            let _ = try ProjectCreator(name: "Target" + String(q),
                                       username: userName,
                                       manager: 0,
                                       target: false,
                                       fatherName: projectName,
                                       son_count: 0)
            if projectType == 2 {
                let context: [String: Any] = ["name": "Target" + String(q)]

                let environment = Environment(loader: FileSystemLoader(paths: ["templates/"]))
                let rendered = try environment.renderTemplate(name: "podspec_template.html", context: context)
                let fileTemplate = rendered
                lol_.createFile(name: "Target" + String(q),
                                type: "podspec",
                                path: URL(string: "file:///tmp/gena/\(projectName)/Sources/\("Target" + String(q))/"),
                                data: fileTemplate)
            }
            for i in 0 ..< targetClasses {
                lol_.createFile(name: "Class_\("Target" + String(q))" + String(i),
                                type: "swift",
                                path: URL(string: "file:///tmp/gena/\(projectName)/Sources/\("Target" + String(q))/Sources/\("Target" + String(q))/Classes/"),
                                data: try ClassCreator(countFunc: targetClassesFunc, number: i, template: "class_template.html", name: "CLASS_\("Target" + String(q) + String(i))").fileTemplate)
            }

            for i in 0 ..< targetStructs {
                lol_.createFile(name: "Struct_\("Target" + String(q))" + String(i),
                                type: "swift",
                                path: URL(string: "file:///tmp/gena/\(projectName)/Sources/\("Target" + String(q))/Sources/\("Target" + String(q))/Structs/"),
                                data: try ClassCreator(countFunc: targetStructsFunc, number: i, template: "struct_template.html", name: "STRUCT_\("Target" + String(q) + String(i))").fileTemplate)
            }
        }

        print("success")
    }
}

// print("Write username")
// let userName = readLine()

// print("Write project name:")
// let projectName = readLine()

// print("Write dependensies Manager (spm - 1, cocoapods - 2)")
// let projType = readLine()
// let projTypeInt = Int(projType ?? "0")

// let pc = try ProjectCreator(name: projectName ?? "Project",
//                             username: userName ?? "lexar",
//                             manager: projTypeInt ?? 1)

// print("Write class count:")
// let class_count = readLine()
// let cc = Int(class_count ?? "0")

// print("write struct count:")
// let struct_count = readLine()
// let sc = Int(struct_count ?? "0")

// let lol_ = FileCreator()

// for i in 0 ... (cc ?? 0) {
//     lol_.createFile(name: "Class_" + String(i),
//                     type: "swift",
//                     path: URL(string: "file:///home/\(userName ?? "lexar")/\(projectName ?? "Project")/Sources/\(projectName ?? "Project")/Classes/"),
//                     data: try ClassCreator(count: cc ?? 0, number: i, template: "class_template.html", name: "CLASS_").fileTemplate)
// }

// for i in 0 ... (sc ?? 0) {
//     lol_.createFile(name: "Struct_" + String(i),
//                     type: "swift",
//                     path: URL(string: "file:///home/\(userName ?? "lexar")/\(projectName ?? "Project")/Sources/\(projectName ?? "Project")/Structs/"),
//                     data: try ClassCreator(count: sc ?? 0, number: i, template: "struct_template.html", name: "STRUCT_").fileTemplate)
// }

// project struct
/*
 Creating library package: lol
 Creating Package.swift
 Creating README.md
 Creating .gitignore
 Creating Sources/
 Creating Sources/lol/lol.swift
 Creating Tests/
 Creating Tests/lolTests/
 Creating Tests/lolTests/lolTests.swift
 */
