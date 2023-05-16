// swift-tools-version: 5.5

import PackageDescription


let package = Package(
    name: "SDKWorkbench",
    platforms: [.macOS(.v12), .iOS(.v15)],
    dependencies: [
        .package(url: "https://github.com/awslabs/aws-sdk-swift.git", branch: "main"),
        .package(url: "https://github.com/awslabs/smithy-swift.git", branch: "main"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "CLITool", 
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "AWSSTS", package: "aws-sdk-swift")
            ]
        ),
        .testTarget(name: "CLIToolTests", dependencies: ["CLITool"]),
    ]
)
