import Foundation

struct CityModel: Identifiable, Hashable {
    var id: String { "\(title)_\(yandexCode ?? "")" }
    let title: String
    let yandexCode: String?
    let stations: [StationModel]
}
