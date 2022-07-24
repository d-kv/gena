import Foundation
import Stencil

struct Pack {
    let packName: String
    let packUrl: String
}

class PackageCreator {
    var fileTemplate: String

    init() {
        fileTemplate = ""
    }

    func podfileCreate(count: Int, name: String) throws {
        let context: [String: Any] = ["packages": returnPackNames(count: count, pack_system: 1),
                                      "name": name]
        let environment = Environment(loader: FileSystemLoader(paths: ["templates/"]))
        let rendered = try environment.renderTemplate(name: "podfile_template.html", context: context)
        fileTemplate = rendered
    }

    func packageCreate(count: Int, name: String) throws {
        let context: [String: Any] = ["packages": returnPackNames(count: count, pack_system: 2),
                                      "name": name]
        let environment = Environment(loader: FileSystemLoader(paths: ["templates/"]))
        let rendered = try environment.renderTemplate(name: "package_template.html", context: context)
        fileTemplate = rendered
    }
}

func returnPackNames(count _: Int, pack_system _: Int) -> [Pack] {
    []
}
