// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SpencilTry",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.0.0"),
        .package(url: "https://github.com/stencilproject/Stencil.git", from: "0.14.1"),
    ],
    targets: [
        .executableTarget(
            name: "SpencilTry",
            dependencies: [
                "Stencil",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .testTarget(
            name: "SpencilTryTests",
            dependencies: ["SpencilTry"]
        ),
    ]
)
