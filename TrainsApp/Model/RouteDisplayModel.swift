import Foundation

struct RouteDisplayModel: Identifiable, Hashable {
    let id: String
    let carrierName: String
    let carrierLogoURL: URL?
    let transferInfo: String?
    let departureTime: String
    let arrivalTime: String
    let duration: String
    let dateText: String
}
