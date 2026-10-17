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

extension AllStations {
    func toCities() -> [CityModel] {
        let allCountries: [Components.Schemas.Country] = countries ?? []
        
        let allRegions: [Components.Schemas.Region] = allCountries
            .flatMap { $0.regions ?? [] }
        
        let allSettlements: [Components.Schemas.Settlement] = allRegions
            .flatMap { $0.settlements ?? [] }
        
        let cities: [CityModel] = allSettlements.compactMap { settlement in
            guard let title = settlement.title, !title.isEmpty else { return nil }
            
            let stations: [StationModel] = (settlement.stations ?? []).compactMap { station in
                guard let stationTitle = station.title, !stationTitle.isEmpty else { return nil }
                return StationModel(
                    title: stationTitle,
                    yandexCode: station.codes?.yandex_code
                )
            }
            
            return CityModel(
                title: title,
                yandexCode: settlement.codes?.yandex_code,
                stations: stations
            )
        }
        
        return cities.sorted {
            $0.title.localizedCompare($1.title) == .orderedAscending
        }
    }
}
