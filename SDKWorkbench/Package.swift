// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SDKWorkbench",
    platforms: [.macOS(.v12), .iOS(.v15)],
    dependencies: [
        .package(url: "https://github.com/awslabs/aws-sdk-swift.git", branch: "main"),
    ],
    targets: [
        .executableTarget(
            name: "CLITool",
            dependencies: [
                .product(name: "AWSSTS", package: "aws-sdk-swift"),
            ]
        ),
    ]
)
