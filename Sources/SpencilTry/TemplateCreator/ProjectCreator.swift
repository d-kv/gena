import Foundation

class ProjectCreator {
    init(name: String, username: String, manager: Int, target: Bool, fatherName: String, son_count: Int) throws {
        if target {
            let fm = FileCreator()
            let pc = PackageCreator()
            commonPart(fm: fm, name: name, username: username)
            switch manager {
            case 1:
                try pc.packageCreate(count: 0, name: name, targetcount: son_count)
                fm.createFile(name: "Package", type: "swift",
                              path: URL(string: "file:///tmp/gena/\(name)/"),
                              data: pc.fileTemplate)

            case 2:
                try pc.podfileCreate(count: 0, name: name, targetcount: son_count)
                fm.createFile(name: "Podfile", type: "",
                              path: URL(string: "file:///tmp/gena/\(name)/"),
                              data: pc.fileTemplate)
                try pc.ymlCreate(count: 0, name: name, targetcount: son_count)
                fm.createFile(name: "project", type: "yml",
                              path: URL(string: "file:///tmp/gena/\(name)/"),
                              data: pc.fileTemplate)

            default: break
            }
        } else {
            let fm = FileCreator()
            commonCommonPart(fm: fm, name: name, username: username, fatherName: fatherName)
        }
    }

    func commonPart(fm: FileCreator, name: String, username _: String) {
        fm.createFolder(name: name,
                        path: "/tmp/gena/")
        fm.createFolder(name: "Sources",
                        path: "/tmp/gena/\(name)/")
        fm.createFolder(name: name,
                        path: "/tmp/gena/\(name)/Sources/")
        fm.createFile(name: "main",
                      type: "swift",
                      path: URL(string: "file:///tmp/gena/\(name)/Sources/\(name)"),
                      data: "print(\"hellowrld\")")
        fm.createFolder(name: "Structs", path: "/tmp/gena/\(name)/Sources/\(name)/")
        fm.createFolder(name: "Classes", path: "/tmp/gena/\(name)/Sources/\(name)/")
    }

    func commonCommonPart(fm: FileCreator, name: String, username _: String, fatherName: String) {
        fm.createFolder(name: name,
                        path: "/tmp/gena/\(fatherName)/Sources/")
        fm.createFolder(name: "Sources",
                        path: "/tmp/gena/\(fatherName)/Sources/\(name)/")
        fm.createFolder(name: name,
                        path: "/tmp/gena/\(fatherName)/Sources/\(name)/Sources/")

        fm.createFile(name: "name",
                      type: "swift",
                      path: URL(string: "file:///tmp/gena/\(fatherName)/Sources/\(name)/Sources/\(name)"),
                      data: " ")
        fm.createFolder(name: "Structs", path: "/tmp/gena/\(fatherName)/Sources/\(name)/Sources/\(name)/")
        fm.createFolder(name: "Classes", path: "/tmp/gena/\(fatherName)/Sources/\(name)/Sources/\(name)/")
    }
}

// lol_.createFolder(name: "folder",
//                  path: "/home/lexar/TestProjects/")

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
