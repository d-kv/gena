import Foundation
import Stencil

print("Write username")
let userName = readLine()

print("Write project name:")
let projName = readLine()

print("Write dependensies Manager (spm - 1, cocoapods - 2)")
let projType = readLine()
let projTypeInt = Int(projType ?? "0")

let pc = try ProjectCreator(name: projName ?? "Project",
                            username: userName ?? "lexar",
                            manager: projTypeInt ?? 1)

print("Write class count:")
let class_count = readLine()
let cc = Int(class_count ?? "0")

print("write struct count:")
let struct_count = readLine()
let sc = Int(struct_count ?? "0")

let lol_ = FileCreator()

for i in 0 ... (cc ?? 0) {
    lol_.createFile(name: "Class_" + String(i),
                    type: "swift",
                    path: URL(string: "file:///home/\(userName ?? "lexar")/\(projName ?? "Project")/Sources/\(projName ?? "Project")/Classes/"),
                    data: try ClassCreator(count: cc ?? 0, number: i, template: "class_template.html", name: "CLASS_").fileTemplate)
}

for i in 0 ... (sc ?? 0) {
    lol_.createFile(name: "Struct_" + String(i),
                    type: "swift",
                    path: URL(string: "file:///home/\(userName ?? "lexar")/\(projName ?? "Project")/Sources/\(projName ?? "Project")/Structs/"),
                    data: try ClassCreator(count: sc ?? 0, number: i, template: "struct_template.html", name: "STRUCT_").fileTemplate)
}

print("success")

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
