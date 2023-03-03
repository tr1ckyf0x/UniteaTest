// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StreamPlayer",
    products: [
        .library(
            name: "StreamPlayer",
            targets: ["StreamPlayer"]
        )
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "StreamPlayer",
            dependencies: []
        )
    ]
)
