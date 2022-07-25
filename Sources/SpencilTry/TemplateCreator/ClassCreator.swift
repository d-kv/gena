import Foundation
import Stencil

enum TypeNames: String {
    case int = ": Int, "
    case string = ": String, "
    case bool = ": Bool"
}

struct Class {
    let funcName: String
    let funcArgument: String
}

class ClassCreator {
    var fileTemplate: String

    init(countFunc: Int, number: Int, template: String, name: String) throws {
        let context: [String: Any] = ["classes": returnClassNames(count: countFunc),
                                      "name": name + String(number)]
        let environment = Environment(loader: FileSystemLoader(paths: ["templates/"]))
        let rendered = try environment.renderTemplate(name: template, context: context)
        fileTemplate = rendered
    }
    /* let class_count = readLine()
     let a = Int(class_count ?? "0")
     print(a ?? "0")
     let environment = Environment(loader: FileSystemLoader(paths: ["templates/"]))
     let rendered = try environment.renderTemplate(name: "articles.html", context: context)
     */
}

func returnClassNames(count: Int) -> [Class] {
    var classes: [Class] = []
    for i in 0 ..< count {
        classes.append(Class(funcName: randName(num: i), funcArgument: randArgument()))
    }
    return classes
}

func randName(num: Int) -> String {
    return "name" + String(num)
}

func randArgument() -> String {
    var sum = ""
    sum = "a" + TypeNames.int.rawValue +
        "a1" + TypeNames.string.rawValue +
        "a2" + TypeNames.bool.rawValue
    return sum
}
