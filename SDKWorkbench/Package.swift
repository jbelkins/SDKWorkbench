// swift-tools-version: 5.5

import PackageDescription


let package = Package(
    name: "SDKWorkbench",
    platforms: [.macOS(.v12), .iOS(.v15)],
    dependencies: [
        .package(url: "https://github.com/awslabs/aws-sdk-swift.git", branch: "jbe/to_be_main"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.0.0"),
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "CLITool", 
            dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")]
        ),
        .target(
            name: "VaporApp",
            dependencies: [.product(name: "Vapor", package: "vapor")]
        ),
        .executableTarget(
            name: "VaporRun",
            dependencies: [.target(name: "VaporApp")]
        ),
        .testTarget(name: "CLIToolTests", dependencies: ["CLITool"]),
        .testTarget(name: "VaporAppTests", dependencies: [.target(name: "VaporApp"), .product(name: "XCTVapor", package: "vapor")
        ])
    ]
)
