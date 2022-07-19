import Foundation

class ProjectCreator{

    init(name: String, username: String, manager: Int) throws {
        switch manager{
            case 1:
                let fm = FileCreator()
                fm.createFolder(name: name, 
                                path: "/home/\(username)/")
                fm.createFolder(name: "Sources", 
                                path: "/home/\(username)/\(name)/")
                fm.createFolder(name: name, 
                                path: "/home/\(username)/\(name)/Sources/")
                fm.createFile(name: "Package", type: "swift", 
                                path: URL(string: "file:///home/\(username)/\(name)/"), 
                                data: try PackageCreator(count: 0, name: name).fileTemplate)
                fm.createFile(name: "README", type: "md", 
                            path: URL(string: "file:///home/\(username)/\(name)/"), 
                            data: "Readme file")
                fm.createFile(name: "main", 
                            type: "swift", 
                            path: URL(string: "file:///home/\(username)/\(name)/Sources/\(name)"), 
                            data: "print(\"hellowrld\")")
                fm.createFolder(name: "Structs", path: "/home/\(username)/\(name)/Sources/\(name)/")
                fm.createFolder(name: "Classes", path: "/home/\(username)/\(name)/Sources/\(name)/")
            default: break
        }
        
    }
}
//lol_.createFolder(name: "folder",
//                  path: "/home/lexar/TestProjects/")

//project struct
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