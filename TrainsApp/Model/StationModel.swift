import Foundation

struct StationModel: Identifiable, Hashable {
    var id: String { "\(title)_\(yandexCode ?? "")" }
    let title: String
    let yandexCode: String?
}
