import Foundation

extension Segments {
    func toDisplayModels(on date: Date) -> [RouteDisplayModel] {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ru_RU")
        df.dateFormat = "d MMMM"
        let dateString = df.string(from: date)

        return (segments ?? []).compactMap { segment in
            guard let departure = segment.departure else { return nil }
            return RouteDisplayModel(
                id: UUID().uuidString,
                carrierName: segment.thread?.carrier?.title ?? "Перевозчик",
                carrierLogoURL: logoURL(from: segment.thread?.carrier?.logo),
                transferInfo: nil,
                departureTime: shortTime(departure),
                arrivalTime: shortTime(segment.arrival),
                duration: shortDuration(segment.duration),
                dateText: dateString
            )
        }
    }
}

private func logoURL(from raw: String?) -> URL? {
    guard let raw, !raw.isEmpty else { return nil }
    if raw.hasPrefix("//") {
        return URL(string: "https:" + raw)
    }
    return URL(string: raw)
}

private func shortTime(_ raw: String?) -> String {
    guard let raw else { return "--:--" }
    if let tIndex = raw.firstIndex(of: "T") {
        let time = raw[raw.index(after: tIndex)...]
        return String(time.prefix(5))
    }
    guard raw.count >= 5 else { return "--:--" }
    return String(raw.prefix(5))
}

private func shortDuration(_ seconds: Int?) -> String {
    guard let s = seconds, s > 0 else { return "" }
    let h = s / 3600, m = (s % 3600) / 60
    return h > 0 ? "\(h) ч \(m) мин" : "\(m) мин"
}
