import ArgumentParser
import AWSSTS

@main
struct CLIToolRun: AsyncParsableCommand {

    func run() async throws {
        let client = try STSClient(region: "us-east-1")
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
}
