import OpenAPIURLSession
import OpenAPIRuntime

typealias CopyrightResponse = Components.Schemas.CopyrightResponse


protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> CopyrightResponse
}

// MARK: - CopyrightService
final class CopyrightService: CopyrightServiceProtocol {
    // MARK: - Properties
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    // MARK: - Public Methods
    func getCopyright() async throws -> CopyrightResponse {
        let response = try await client.getCopyright(query: .init(
            apikey: apikey
        ))
        
        return try response.ok.body.json
    }
}
