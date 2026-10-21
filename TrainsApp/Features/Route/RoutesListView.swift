import SwiftUI

struct RoutesListView: View {
    let from: String
    let to: String
    let fromCode: String
    let toCode: String

    @State private var allRoutes: [RouteDisplayModel] = []
    @State private var isLoading = false
    
    @State private var isMorningSelected = false
    @State private var isDaySelected = false
    @State private var isEveningSelected = false
    @State private var isNightSelected = false
    @State private var showTransfers = false
    @State private var error: AppError?
    
    private var anyTimeSelected: Bool {
        isMorningSelected || isDaySelected || isEveningSelected || isNightSelected
    }

    private var routes: [RouteDisplayModel] {
        allRoutes.filter { route in
            if anyTimeSelected {
                let hour = Int(route.departureTime.prefix(2)) ?? 0
                let matchesTime =
                    (isMorningSelected && (6..<12).contains(hour)) ||
                    (isDaySelected && (12..<18).contains(hour)) ||
                    (isEveningSelected && (hour >= 18 || hour == 0)) ||
                    (isNightSelected && (0..<6).contains(hour))
                if !matchesTime { return false }
            }
            
            if showTransfers {
                return true
            } else {
                return route.transferInfo == nil || route.transferInfo?.isEmpty == true
            }
        }
    }

    var body: some View {
        ZStack {
            Color.whiteDayNight.ignoresSafeArea()
            if let error {
                ErrorStateView(error: error) {
                    Task { await loadRoutes(force: true) }
                }
            } else {
                VStack(spacing: 16) {
                    Text("\(from) → \(to)")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.blackDayNight)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                    
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(routes) { route in
                                RouteCardView(route: route)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 84)
                    }
                    .scrollIndicators(.hidden)
                }
            }
            VStack {
                Spacer()
                NavigationLink {
                    FilterView(
                        isMorningSelected: $isMorningSelected,
                        isDaySelected: $isDaySelected,
                        isEveningSelected: $isEveningSelected,
                        isNightSelected: $isNightSelected,
                        showTransfers: $showTransfers
                    )
                } label: {
                    Text("Уточнить время")
                        .font(.system(size: 17, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color.blueUniversal)
                        .foregroundStyle(.whiteUniversal)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                }
            }
        }
        .task { await loadRoutes() }
    }

    private func loadRoutes(force: Bool = false) async {
        guard force || allRoutes.isEmpty else { return }
        isLoading = true
        defer { isLoading = false }
        error = nil

        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        var all: [RouteDisplayModel] = []

        for offset in 0..<7 {
            guard let day = calendar.date(byAdding: .day, value: offset, to: today) else { continue }
            do {
                let segments = try await APIConfig.searchService.getScheduleBetweenStations(
                    from: fromCode,
                    to: toCode,
                    date: Self.apiDateFormatter.string(from: day),
                    transportTypes: nil,
                    limit: 100,
                    offset: nil,
                    transfers: true
                )
                all.append(contentsOf: segments.toDisplayModels(on: day))
            } catch {
                self.error = AppError.from(error)
                print("error:", error)
                return
            }
        }

        allRoutes = all
    }

    private static let apiDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd"
        return df
    }()
}

#Preview {
    NavigationStack {
        RoutesListView(
            from: "Москва",
            to: "Санкт-Петербург",
            fromCode: "c213",
            toCode: "c2"
        )
    }
}
