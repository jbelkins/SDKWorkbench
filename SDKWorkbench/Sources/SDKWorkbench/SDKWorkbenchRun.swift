import ArgumentParser
import AWSS3
import ClientRuntime

@main
struct SDKWorkbenchRun: AsyncParsableCommand {
    
    func run() async throws {
        let s3Client = try S3Client(region: "us-east-1")
        let input = HeadBucketInput(bucket: "jbelkins-20221012")
        let acceptors = [
            Acceptor<HeadBucketInput, HeadBucketOutputResponse>(state: .success, matcher: .success(true)),
            Acceptor<HeadBucketInput, HeadBucketOutputResponse>(state: .retry, matcher: .errorType({ $0 is SdkError<HeadBucketOutputError> }))
        ]
        let waiter = Waiter(input: input, acceptors: acceptors, minDelay: 2.0, maxDelay: 10.0, maximumWaitTime: 60.0, operation: s3Client.headBucket(input:))
        for try await status in waiter.asyncSequence() {
            switch status {
            case .success:
                print("Waiter succeeded")
            case .retry(let retryInfo):
                print("Attempt \(retryInfo.attempt)\n    Next attempt in: \(retryInfo.timeUntilNextAttempt). Time until timeout: \(retryInfo.timeUntilTimeout)")
            }
        }
    }
}
