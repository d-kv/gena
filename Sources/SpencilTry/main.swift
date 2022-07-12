import Stencil
import Foundation

struct Article {
  let title: String
  let author: String
}

let context = [
  "articles": [
    Article(title: "function_1", author: "Kyle Fuller"),
    Article(title: "function_2", author: "NE Kyle Fuller"),
    Article(title: "function_3", author: "Lexa Lepexa"),
  ]
]

let environment = Environment(loader: FileSystemLoader(paths: ["templates/"]))
let rendered = try environment.renderTemplate(name: "articles.html", context: context)

print(rendered)
let file = "file.swift" //this is the file. we will write to and read from it

let text = rendered //just a text

if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

    let fileURL = dir.appendingPathComponent(file)

    //writing
    do {
        try text.write(to: fileURL, atomically: false, encoding: .utf8)
    }
    catch {/* error handling here */}

    //reading
    do {
        let text2 = try String(contentsOf: fileURL, encoding: .utf8)
    }
    catch {/* error handling here */}
}
