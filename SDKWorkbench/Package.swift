// swift-tools-version: 5.5

import PackageDescription


let package = Package(
    name: "SDKWorkbench",
    platforms: [.macOS(.v10_15), .iOS(.v13)],
    dependencies: [
        .package(url: "https://github.com/awslabs/aws-sdk-swift.git", branch: "jbe/to_be_main"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.0.0")
    ],
    targets: [
        .executableTarget(
            name: "SDKWorkbench", 
            dependencies: [
                .product(name: "AWSS3", package: "aws-sdk-swift"),
                .product(name: "AWSSTS", package: "aws-sdk-swift"),
                .product(name: "ArgumentParser", package: "swift-argument-parser")]
        ),
        .testTarget(name: "SDKWorkbenchTests", dependencies: ["SDKWorkbench"]),
    ]
)
