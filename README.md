# SDKWorkbench

A simple, flexible development environment for use with the AWS Swift SDK.

SDKWorkbench has the following advantages:
- Removes all development configuration from the SDK repositories, simplifying package configuration.
- Provides simple utility targets (a CLI tool, Swift server, etc.) that can be used to test SDK changes while developing.
- Supports many development options:
  - Develop in Xcode or VSCode
  - Mac, Linux, and (potentially) Windows operating systems
  - x86 and ARM architectures
- Supports use of development containers for highly portable and easily reconfigurable development.
- Using VSCode & dev containers, develop on a remote machine with full editor, debugger, etc. functionality.

## Initial Setup
_(Skip these steps if they have already been performed)_.

1. Create a "working folder" for your development environment, and `cd` into it. (All paths in the steps below are relative to this folder.)

2. Install the SDKWorkbench and local copies of SDK dependencies into your folder:
```
$ git clone git@github.com:jbelkins/SDKWorkbench.git
$ git clone git@github.com:awslabs/aws-sdk-swift.git
$ git clone git@github.com:awslabs/smithy-swift.git
$ git clone --recursive git@github.com:awslabs/aws-crt-swift.git
```

3. Install the AWS CLI tools if needed, and configure your AWS development credentials:
```
$ aws configure
```

## Develop with Xcode (Mac-only)

1. Install latest Xcode, if not already installed.

2. Open the workspace (_not_ the project file) in Xcode:
```
$ open SDKWorkbench/SDKWorkbench.xcworkspace
```
Workspace will open with the three SDK dependencies already in Xcode edit mode.

3. In the Explorer pane, reveal the `SDKWorkbench` package (should be at top) and start developing against the SDK using one of the `SDKWorkbench` targets.  (If you prefer to integrate the SDK with your own project, you can add it to the workspace as well.)

### Xcode Development Tips

If you need to test, run, or do anything else in `SDKWorkspace`, create a Xcode scheme as needed.
Xcode schemes are not auto-created due to the sheer volume of targets in `aws-sdk-swift`.
Make your scheme un-shared and set its container to "SDKWorkbench Workspace" so that it stays local
to your development machine.

## Develop with Visual Studio Code (Mac and Linux, probably Windows too)
_Note: Instructions have been verified on Mac and Linux environments.  I have not tried them on Windows but they should generally work.  Feedback from your experience with Windows would be greatly appreciated._

There are two ways (at least!) to develop with Visual Studio Code:
- On a local or remote Mac or Linux machine, using a Swift toolchain (Xcode CLI Tools on Mac, or Swift for Linux on Linux). VSCode will use:
  - Your locally-installed working copies of the SDK repos
  - Your locally-installed Swift toolchain
- On a local or remote Mac or Linux machine, using a development container.  VSCode will use:
  - Working copies of the SDK repos that are installed on the machine where your container is run
  - A Swift toolchain provided by the development container.

1. Install Visual Studio Code.
- If you want to run directly on your development machine, install Swift from one of the options [here](https://www.swift.org/download/).

2. Open VSCode and install the following plugins:
- Swift (`sswg.swift-lang`)
- Remote - SSH (`ms-vscode-remote.remote-ssh`)
- Dev Containers (`ms-vscode-remote.remote-containers`)

3. If you are using dev containers, perform the following on the machine ("host machine") that will host your dev container.  Your container may either run on the same machine you are running VSCode on, or on a remote host.
- Either install Docker and start it as a service, or install and start Docker Desktop.
- Re-perform the steps in "Initial Setup" above on the host machine, if not already performed there.
- The container will need AWS credentials.  To provide them, create a file named `.env` at `SDKWorkbench/SDKWorkbench/.devcontainer/` with contents:
```
AWS_ACCESS_KEY_ID=<your AWS Access Key ID>
AWS_SECRET_ACCESS_KEY=<your AWS Secret Access Key>
```
(This file will be ignored by Git so your credentials are not committed.)
- Open Docker Desktop & allow it to complete startup.

4. Open the SDKWorkbench package in VSCode:
- If developing remotely, click the green `><` bar in the bottom left corner, then select `Connect to Host...`.  Connect VSCode to your development machine. 
- Open the `SDKWorkbench/SDKWorkbench` folder in a new window (i.e. the folder containing the SDKWorkbench `Package.swift`). You will be prompted to re-open the folder in a dev container if you choose.

Once the VSCode editor opens, the package will install dependencies; they will show in the bottom of the "Explorer" pane on the left.

5. VSCode does not start with any packages in "edit mode".  To place packages in edit mode, see below.

6. Develop on, then run, one of the targets in the `SDKWorkbench` package to use and test SDK features.

### About the Swift SDK Dev Container
- The dev container is built by VSCode as-needed from the official Swift Docker containers, so there is no reliance on any pre-built container that must be maintained.
- The container will "bind" your working folder to the `/workspace` mount point in the container.  So while the container is open, changes made either in the container or on you dev machine's filesystem will show up in both places.

### VSCode Development Tips
- There is currently a [bug](https://github.com/swift-server/vscode-swift/issues/425) in the Swift-VSCode plugin that prevents dependencies from showing in the Dependencies pane if they do not have a name that matches the "default" name shown in their URL.  To place a package in edit mode when it is not showing, use the VSCode CLI (see below).

### Placing a Swift Package in edit mode under VSCode
- Swift Package Manager has two "edit modes" that may be used with VSCode.  The one we will be using with our working copies is the `--path` option, which sets up Swift to build from a local copy of the package that you supply.  (The other form of `swift package edit`, where you make edits on SPM's own checkout, will not be used here.)

To place a package in VSCode edit mode, perform the following:
- Swift Package Manager's `swift package edit` command requires that the package name in a package's manifest match the "inferred" name that recent versions of SPM rely on.  In the local copy of the package to be edited, edit the package name field in the `Package.swift` of the package to be edited, ensuring that the package name is set to the same as the package's enclosing folder (i.e. `aws-sdk-swift`, `smithy-swift`, or `aws-crt-swift`).
- Open the VSCode Bash terminal and type:
```
$ swift package edit --path /workspace/<package-name> <package-name>
```
Once complete, you should see the package marked as "editing" in the Package Dependencies pane.

- To stop editing, open the VSCode Bash terminal and type:
```
$ swift package unedit <package-name>
```
