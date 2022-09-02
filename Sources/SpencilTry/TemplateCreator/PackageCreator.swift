import Foundation
import Stencil

struct Pack {
    let packName: String
    let packUrl: String
}

struct Target {
    let name: String
}

class PackageCreator {
    var fileTemplate: String

    init() {
        fileTemplate = ""
    }

    func podfileCreate(count: Int, name: String, targetcount: Int) throws {
        let context: [String: Any] = ["packages": returnPackNames(count: count, pack_system: 2),
                                      "targets": returnTargetsNames(count: targetcount),
                                      "name": name]
        
        let environment = Environment(loader: FileSystemLoader(paths: ["templates/"]))
        let rendered = try environment.renderTemplate(name: "podfile_template.html", context: context)
        fileTemplate = rendered
    }

    func ymlCreate(count: Int, name: String, targetcount: Int) throws {
        var context: [String: Any] = [:]
        if targetcount == 0 { 
            context = ["packages": returnPackNames(count: count, pack_system: 2),
                                      "targets": [],
                                      "coretarget": [],
                                      "name": name]
        } 
        else if targetcount == 1{
            context = ["packages": returnPackNames(count: count, pack_system: 2),
                                      "targets": [Target(name: "Target0")],
                                      "coretarget": [],
                                      "name": name]
        }

        else {
            
            context = ["packages": returnPackNames(count: count, pack_system: 2),
            "targets": returnTargetsNames(count: targetcount),
            "coretarget": [Target(name: "Target0")],
            "name": name]
        }
        
        let environment = Environment(loader: FileSystemLoader(paths: ["templates/"]))
        let rendered = try environment.renderTemplate(name: "yml_template.html", context: context)
        fileTemplate = rendered
    }


// context: [String: Any] = ["packages": returnPackNames(count: count, pack_system: 2),
//                                       "targets": returnTargetsNames(count: targetcount),
//                                       "name": name]
    func packageCreate(count: Int, name: String, targetcount: Int) throws {
        var context: [String: Any] = [:]
        if targetcount == 0 { 
            context = ["packages": returnPackNames(count: count, pack_system: 2),
                                      "targets": [],
                                      "coretarget": [],
                                      "name": name]
        } 
        else if targetcount == 1{
            context = ["packages": returnPackNames(count: count, pack_system: 2),
                                      "targets": [Target(name: "Target0")],
                                      "coretarget": [],
                                      "name": name]
        }

        else {
            
            context = ["packages": returnPackNames(count: count, pack_system: 2),
            "targets": returnTargetsNames(count: targetcount),
            "coretarget": [Target(name: "Target0")],
            "name": name]
        }
        
        let environment = Environment(loader: FileSystemLoader(paths: ["templates/"]))
        let rendered = try environment.renderTemplate(name: "package_template.html", context: context)
        fileTemplate = rendered
    }
}

func returnPackNames(count: Int, pack_system: Int) -> [Pack] {
    let all_frameworks = [["Alamofire", "pod 'Alamofire'", ".Package(url: \"https://github.com/Alamofire/Alamofire.git\", branch: \"master\")"],
                          [""]]
    var result: [Pack] = []
    switch pack_system {
    case 1:
        for i in 0 ..< count {
            let a = Pack(packName: all_frameworks[i][1], packUrl: all_frameworks[i][3])
            result.append(a)
        }
    case 2:
        for i in 0 ..< count {
            let a = Pack(packName: all_frameworks[i][1], packUrl: all_frameworks[i][2])
            result.append(a)
        }
    default: break
    }
    return result
}

func returnTargetsNames(count: Int) -> [Target] {
    var result: [Target] = []
    for i in 1 ..< count {
        result.append(Target(name: "Target" + String(i)))
    }

    return result
}

// .Package(url: "https://github.com/Alamofire/Alamofire.git", branch: "master") Alamofire pod 'Alamofire'
