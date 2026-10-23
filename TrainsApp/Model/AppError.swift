import Foundation

enum AppError: Equatable {
    case internet
    case server

    static func from(_ error: Error) -> AppError {
        let ns = error as NSError
        guard ns.domain == NSURLErrorDomain else { return .server }
        switch ns.code {
        case NSURLErrorNotConnectedToInternet,
             NSURLErrorNetworkConnectionLost,
             NSURLErrorCannotFindHost,
             NSURLErrorCannotConnectToHost,
             NSURLErrorTimedOut:
            return .internet
        default:
            return .server
        }
    }
}
