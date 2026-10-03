import Foundation
import OpenAPIURLSession
import OpenAPIRuntime

enum SmokeCheckConfig {
    static let apikey = "your api key"

    static func makeClient() throws -> Client {
        Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
    }
}
