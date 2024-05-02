import ArgumentParser
import Foundation
import AWSSTS
import AWSClientRuntime
//import AWSRoute53

@main
struct CLIToolRun: AsyncParsableCommand {

    func run() async throws {
        let credentials = 
        let config = STSClient.Config(awsCredentialIdentityResolver: StaticAWSCredentialIdentityResolver(<#AWSCredentialIdentity#>)
        let client = try STSClient(config: config)
        let input = GetCallerIdentityInput()
        do {
            let output = try await client.getCallerIdentity(input: input)
            let userID = String(describing: output.userId)
            let account = String(describing: output.account)
            print("Request succeeded")
            print("User ID: \(userID)")
            print("Account: \(account)")
        } catch {
            print("Request failed")
            print("Error: \(error)")
        }
    }

//    func run() async throws {
//        let client = try S3Client(region: "us-west-2")
//        let input = ListBucketsInput()
//        let output = try await client.listBuckets(input: input)
//        for bucket in output.buckets ?? [] where bucket.name?.hasPrefix("aws-sdk-s3-integration-test-") ?? false {
//            let input = ListObjectsV2Input(bucket: bucket.name)
//            let output = try await client.listObjectsV2(input: input)
//            for object in output.contents ?? [] {
//                let input = DeleteObjectInput(bucket: bucket.name, key: object.key)
//                let _ = try await client.deleteObject(input: input)
//            }
//            let input0 = DeleteBucketInput(bucket: bucket.name)
//            do {
//                let _ = try await client.deleteBucket(input: input0)
//            } catch let error as AWSServiceError where error.errorCode == "BucketHasAccessPointsAttached" {
//                // Ignore this error & leave this bucket
//            }
//        }
//    }
}
