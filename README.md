# SDKWorkbench

An Xcode development environment for use with the AWS Swift SDK.

## Setup

1. Install the SDKWorkbench and local copies of SDK dependencies:
```
$ git clone git@github.com:jbelkins/SDKWorkbench.git
$ cd SDKWorkbench
$ git clone git@github.com:awslabs/aws-sdk-swift.git
$ git clone git@github.com:awslabs/smithy-swift.git
$ git clone --recursive git@github.com:awslabs/aws-crt-swift.git
```

## Develop with Xcode
Open the workspace (_not_ the project file) in Xcode:
```
$ open SDKWorkbench.xcworkspace
```
Workspace will open with the three SDK dependencies in Xcode edit mode.

## Using SDKWorkspace

If you need to test, run, or do anything else in `SDKWorkspace`, create a Xcode scheme as needed.
Xcode schemes are not auto-created due to the sheer volume of targets in `aws-sdk-swift`.
Make your scheme un-shared and set its container to "SDKWorkbench Workspace" so that it stays local
to your development machine.

Edit as needed on the three local copies of packages, and push/pull changes to Github as needed.
