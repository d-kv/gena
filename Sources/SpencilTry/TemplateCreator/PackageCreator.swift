import Foundation
import Stencil

struct Pack {
  let packName: String
  let packUrl: String
}


class PackageCreator{
    var fileTemplate: String

    init (count: Int, name: String) throws {
        let context: [String: Any] = ["packages": returnPackNames(count: count),
                                        "name": name]
        let environment = Environment(loader: FileSystemLoader(paths: ["templates/"]))
        let rendered = try environment.renderTemplate(name: "package_template.html", context: context)
        fileTemplate = rendered
    }
}

func returnPackNames(count: Int) -> [Pack]{
    []
}