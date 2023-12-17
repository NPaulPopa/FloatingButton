// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FloatingButton",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "FloatingButton",targets: ["FloatingButton"]),
    ],
    dependencies: [
        
        .package(url: "https://github.com/NPaulPopa/ItemsThemes.git", branch: "main"),
    ],
    
    targets: [
        .target(name: "FloatingButton", dependencies: [
            
            .productItem(name: "Themes", package: "ItemsThemes", condition: nil),
        ]),
        
        .testTarget(name: "FloatingButtonTests", dependencies: ["FloatingButton"]),
    ]
)
