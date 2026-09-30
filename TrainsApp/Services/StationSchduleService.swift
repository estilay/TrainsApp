import OpenAPIURLSession
import OpenAPIRuntime

typealias ScheduleResponse = Components.Schemas.ScheduleResponse

protocol StationScheduleServiceProtocol {
    func getStationSchedule(
        station: String,
        date: String?,
        transportTypes: String?,
        event: String?,
        direction: String?,
        system: String?
    ) async throws -> ScheduleResponse
}

// MARK: - StationScheduleService
final class StationScheduleService: StationScheduleServiceProtocol {
    // MARK: - Properties
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    // MARK: - Public Methods
    func getStationSchedule(
        station: String,
        date: String? = nil,
        transportTypes: String? = nil,
        event: String? = nil,
        direction: String? = nil,
        system: String? = nil
    ) async throws -> ScheduleResponse {
        let response = try await client.getStationSchedule(query: .init(
            apikey: apikey,
            station: station,
            date: date,
            transport_types: transportTypes,
            event: event,
            direction: direction,
            system: system
        ))
        
        return try response.ok.body.json
    }
}
