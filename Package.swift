// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "SpencilTry",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.0.0"),
        .package(url: "https://github.com/stencilproject/Stencil.git", from: "0.14.1"),
        .package(url: "https://github.com/swiftcsv/SwiftCSV.git", from: "0.8.0"),
    ],
    targets: [
        .executableTarget(
            name: "Runner",
            dependencies: [
                "SpencilTry",
                "SwiftCSV",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),

            ],
            path: "Sources/Runner"
        ),
        .executableTarget(
            name: "SpencilTry",
            dependencies: [
                "Stencil",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "Sources/SpencilTry"
        ),
    ]
)
// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

// import PackageDescription

// let package = Package(
//     name: "SpencilTry",
//     dependencies: [
//         .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.0.0"),
//         .package(url: "https://github.com/stencilproject/Stencil.git", from: "0.14.1"),
//     ],
//     targets: [
//         .executableTarget(
//             name: "SpencilTry",
//             dependencies: [
//                 "Stencil",
//                 .product(name: "ArgumentParser", package: "swift-argument-parser"),
//             ]
//         ),
//         .testTarget(
//             name: "SpencilTryTests",
//             dependencies: ["SpencilTry"]
//         ),
//     ]
// )
