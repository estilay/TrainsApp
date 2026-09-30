import OpenAPIURLSession
import OpenAPIRuntime

typealias ThreadStationsResponse = Components.Schemas.ThreadStationsResponse

protocol RouteStationsServiceProtocol {
    func getRouteStations(
        uid: String,
        from: String?,
        to: String?,
        date: String?,
        showSystems: String?
    ) async throws -> ThreadStationsResponse
}

// MARK: - RouteStationsService
final class RouteStationsService: RouteStationsServiceProtocol {
    // MARK: - Properties
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    // MARK: - Public Methods
    func getRouteStations(
        uid: String,
        from: String? = nil,
        to: String? = nil,
        date: String? = nil,
        showSystems: String? = nil
    ) async throws -> ThreadStationsResponse {
        let response = try await client.getRouteStations(query: .init(
            apikey: apikey,
            uid: uid,
            from: from,
            to: to,
            date: date,
            show_systems: showSystems
        ))
        
        return try response.ok.body.json
    }
}
