// swift-tools-version:4.2

import PackageDescription

/// - Note: run `swift package update && rake xcodeproj` to update dependencies project
/// - SeeAlso: https://www.ralfebert.de/ios-examples/xcode/ios-dependency-management-with-swift-package-manager

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
