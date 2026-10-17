import OpenAPIURLSession

enum APIConfig {
    static let apiKey = "APIKEY"
    
    static let client: Client = {
        try! Client(
            serverURL: Servers.Server1.url(),
            transport: URLSessionTransport()
        )
    }()
    
    static let allStationsService: AllStationsServiceProtocol = AllStationsService(
        client: client,
        apikey: apiKey
    )
}
