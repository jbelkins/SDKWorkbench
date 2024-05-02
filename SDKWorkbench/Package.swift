// swift-tools-version: 5.7

import PackageDescription


let package = Package(
    name: "SDKWorkbench",
    platforms: [.macOS(.v12), .iOS(.v15)],
    dependencies: [
        .package(url: "https://github.com/awslabs/aws-sdk-swift.git", branch: "main"),
//        .package(url: "https://github.com/awslabs/smithy-swift.git", branch: "main"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "CLITool", 
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "AWSSTS", package: "aws-sdk-swift"),
//                .product(name: "AWSRoute53", package: "aws-sdk-swift"),
//                .product(name: "AWSS3", package: "aws-sdk-swift"),
            ],
            linkerSettings: [
                .unsafeFlags(
                    ["-Xlinker", "-sectcreate",
                     "-Xlinker", "__TEXT",
                     "-Xlinker", "__info_plist",
                     "-Xlinker", "Resources/Info.plist"
                    ]
                )
            ]
        )
    ]
)
