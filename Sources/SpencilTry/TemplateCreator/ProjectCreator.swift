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
                              path: URL(string: "file:///home/\(username)/\(name)/"),
                              data: pc.fileTemplate)

            case 2:
                try pc.podfileCreate(count: 0, name: name)
                fm.createFile(name: "Podfile", type: "",
                              path: URL(string: "file:///home/\(username)/\(name)/"),
                              data: pc.fileTemplate)

            default: break
            }
        } else {
            let fm = FileCreator()
            commonCommonPart(fm: fm, name: name, username: username, fatherName: fatherName)
        }
    }

    func commonPart(fm: FileCreator, name: String, username: String) {
        fm.createFolder(name: name,
                        path: "/home/\(username)/")
        fm.createFolder(name: "Sources",
                        path: "/home/\(username)/\(name)/")
        fm.createFolder(name: name,
                        path: "/home/\(username)/\(name)/Sources/")
        fm.createFile(name: "README", type: "md",
                      path: URL(string: "file:///home/\(username)/\(name)/"),
                      data: "Readme file")
        fm.createFile(name: "main",
                      type: "swift",
                      path: URL(string: "file:///home/\(username)/\(name)/Sources/\(name)"),
                      data: "print(\"hellowrld\")")
        fm.createFolder(name: "Structs", path: "/home/\(username)/\(name)/Sources/\(name)/")
        fm.createFolder(name: "Classes", path: "/home/\(username)/\(name)/Sources/\(name)/")
    }

    func commonCommonPart(fm: FileCreator, name: String, username: String, fatherName: String) {
        fm.createFolder(name: name,
                        path: "/home/\(username)/\(fatherName)/Sources/")
        fm.createFolder(name: "Sources",
                        path: "/home/\(username)/\(fatherName)/Sources/\(name)/")
        fm.createFolder(name: name,
                        path: "/home/\(username)/\(fatherName)/Sources/\(name)/Sources/")
        fm.createFile(name: "README", type: "md",
                      path: URL(string: "file:///home/\(username)/\(fatherName)/Sources/\(name)/"),
                      data: "Readme file")
        fm.createFile(name: "name",
                      type: "swift",
                      path: URL(string: "file:///home/\(username)/\(fatherName)/Sources/\(name)/Sources/\(name)"),
                      data: " ")
        fm.createFolder(name: "Structs", path: "/home/\(username)/\(fatherName)/Sources/\(name)/Sources/\(name)/")
        fm.createFolder(name: "Classes", path: "/home/\(username)/\(fatherName)/Sources/\(name)/Sources/\(name)/")
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
