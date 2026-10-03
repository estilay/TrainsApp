import OpenAPIURLSession
import OpenAPIRuntime

typealias Segments = Components.Schemas.Segments

protocol SearchServiceProtocol {
    func getScheduleBetweenStations(
        from: String,
        to: String,
        date: String?,
        transportTypes: String?,
        limit: Int?,
        offset: Int?
    ) async throws -> Segments
}

// MARK: - SearchService
final class SearchService: SearchServiceProtocol {
    // MARK: - Properties
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    // MARK: - Public Methods
    func getScheduleBetweenStations(
        from: String,
        to: String,
        date: String? = nil,
        transportTypes: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil
    ) async throws -> Segments {
        let response = try await client.getScheduleBetweenStations(query: .init(
            apikey: apikey,
            from: from,
            to: to,
            date: date,
            transport_types: transportTypes,
            offset: offset,
            limit: limit
        ))
        
        return try response.ok.body.json
    }
}
