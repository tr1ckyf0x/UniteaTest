// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ITunesAPI",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "ITunesAPI",
            targets: ["ITunesAPI"]
        )
    ],
    dependencies: [
        .package(path: "../APIClient")
    ],
    targets: [
        .target(
            name: "ITunesAPI",
            dependencies: [
                "APIClient"
            ]
        )
    ]
)
