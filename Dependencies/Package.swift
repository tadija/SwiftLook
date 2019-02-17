// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Dependencies",
    products: [
        .library(name: "Dependencies", type: .dynamic, targets: ["Dependencies"]),
    ],
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Splash", .branch("master")),
    ],
    targets: [
        .target(name: "Dependencies", dependencies: ["Splash"], path: "." )
    ]
)
