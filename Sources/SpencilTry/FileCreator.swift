import Foundation

class FileCreator {
    func createFile(name: String, type: String, path: URL?, data: String) {
        guard let fileURL = path?.appendingPathComponent(name).appendingPathExtension(type) else {
            fatalError("Not able to create URL")
        }

        // Writing to the file named Test
        do {
            try data.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            assertionFailure("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
        }
    }

    func createFolder(name: String, path: String) {
        let manager = FileManager()
        do {
            try manager.createDirectory(atPath: path + name, withIntermediateDirectories: true)
        } catch _ as NSError {
            print("Error while creating a folder.")
        }
    }
}
