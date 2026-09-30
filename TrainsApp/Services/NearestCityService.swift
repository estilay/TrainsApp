import OpenAPIURLSession
import OpenAPIRuntime

typealias NearestCityResponse = Components.Schemas.NearestCityResponse

protocol NearestCityServiceProtocol {
    func getNearestCity(
        lat: Double,
        lng: Double,
        distance: Int?
    ) async throws -> NearestCityResponse
}

// MARK: - NearestCityService
final class NearestCityService: NearestCityServiceProtocol {
    // MARK: - Properties
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    // MARK: - Public Methods
    func getNearestCity(
        lat: Double,
        lng: Double,
        distance: Int? = nil
    ) async throws -> NearestCityResponse {
        let response = try await client.getNearestCity(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        
        return try response.ok.body.json
    }
}
