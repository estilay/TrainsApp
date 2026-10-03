import Foundation
import OpenAPIURLSession
import OpenAPIRuntime

typealias AllStations = Components.Schemas.AllStationsResponse

protocol AllStationsServiceProtocol {
    func getAllStations() async throws -> AllStations
}


// MARK: - AllStationsService
final class AllStationsService: AllStationsServiceProtocol {
    // MARK: - Properties
    private let client: Client
    private let apikey: String
    private let decoder = JSONDecoder()
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    // MARK: - Public Methods
    func getAllStations() async throws -> AllStations {
        let response = try await client.getAllStations(query: .init(apikey: apikey))
        
        let responseBody = try response.ok.body.html
        
        let limit = 50 * 1024 * 1024 // 50 Mb
        let fullData = try await Data(collecting: responseBody, upTo: limit)
        
        let allStations = try decoder.decode(AllStations.self, from: fullData)
        
        return allStations
    }
}
