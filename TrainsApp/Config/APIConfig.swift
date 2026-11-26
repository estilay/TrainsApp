import OpenAPIURLSession

enum APIConfig {
    static let apiKey = AppConfig.secretAPIKey
    
    static let client: Client = {
        do {
            return try Client(
                serverURL: Servers.Server1.url(),
                transport: URLSessionTransport()
            )
        } catch {
            fatalError("Не удалось создать API Client: \(error)")
        }
    }()
    
    static let allStationsService: AllStationsServiceProtocol = AllStationsService(
        client: client,
        apikey: apiKey
    )
    
    static let searchService: SearchServiceProtocol = SearchService(
        client: client,
        apikey: apiKey
    )
    
    static let carrierInfoService: CarrierInfoServiceProtocol = CarrierInfoService(
        client: client,
        apikey: apiKey
    )
}
