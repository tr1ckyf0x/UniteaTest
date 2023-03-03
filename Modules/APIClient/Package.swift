// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "APIClient",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "APIClient",
            targets: ["APIClient"]
        )
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "APIClient",
            dependencies: []
        ),
        .testTarget(
            name: "APIClientTests",
            dependencies: ["APIClient"]
        )
    ]
)
