import OpenAPIURLSession
import OpenAPIRuntime

typealias CarrierResponse = Components.Schemas.CarrierResponse

protocol CarrierInfoServiceProtocol {
    func getCarrierInfo(
        code: String,
        system: String?
    ) async throws -> CarrierResponse
}

// MARK: - CarrierInfoService
final class CarrierInfoService: CarrierInfoServiceProtocol {
    // MARK: - Properties
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    // MARK: - Public Methods
    func getCarrierInfo(
        code: String,
        system: String? = nil
    ) async throws -> CarrierResponse {
        let response = try await client.getCarrierInfo(query: .init(
            apikey: apikey,
            code: code,
            system: system
        ))
        
        return try response.ok.body.json
    }
}
