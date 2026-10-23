import Foundation
import OpenAPIURLSession
import OpenAPIRuntime

struct RawSegments: Decodable {
    struct RawSegment: Decodable {
        let start_date: String?
    }
    let segments: [RawSegment]?
}
