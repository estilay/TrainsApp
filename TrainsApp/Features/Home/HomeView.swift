import SwiftUI

struct StationRoute: Hashable {
    let field: HomeView.PickField
    let city: CityModel
}

struct RoutesListRoute: Hashable {
    let from: String
    let to: String
    let fromCode: String
    let toCode: String
}

struct HomeView: View {
    @State private var from = ""
    @State private var to = ""
    @State private var fromCode = ""
    @State private var toCode = ""
    
    @State private var path = NavigationPath()
    @State private var cities: [CityModel] = []
    @State private var error: AppError?
    
    enum PickField: Hashable { case from, to }
    
    private var isReadyToSearch: Bool {
        !fromCode.isEmpty && !toCode.isEmpty && fromCode != toCode
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color.whiteDayNight.ignoresSafeArea()
                if let error {
                    ErrorStateView(error: error) {
                        Task { await loadCities(force: true) }
                    }
                } else {
                    VStack(spacing: 16) {
                        DirectionPickerView(
                            from: $from,
                            to: $to,
                            onSelectFrom: { path.append(PickField.from) },
                            onSelectTo:   { path.append(PickField.to) }
                        )
                        
                        if isReadyToSearch {
                            SearchButtonView {
                                path.append(RoutesListRoute(
                                    from: from,
                                    to: to,
                                    fromCode: fromCode,
                                    toCode: toCode
                                ))
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationDestination(for: PickField.self) { field in
                CityPickerView(cities: $cities) { city in
                    path.append(StationRoute(field: field, city: city))
                }
                .toolbar(.hidden, for: .tabBar)
            }
            .navigationDestination(for: StationRoute.self) { route in
                StationPickerView(
                    cityTitle: route.city.title,
                    stations: route.city.stations
                ) { station in
                    let title = "\(route.city.title) (\(station.title))"
                    
                    var transaction = Transaction()
                    transaction.disablesAnimations = true
                    withTransaction(transaction) {
                        path = NavigationPath()
                    }
                    
                    switch route.field {
                    case .from:
                        from = title
                        fromCode = station.yandexCode ?? ""
                    case .to:
                        to = title
                        toCode = station.yandexCode ?? ""
                    }
                }
                .toolbar(.hidden, for: .tabBar)
            }
            .navigationDestination(for: RoutesListRoute.self) { route in
                RoutesListView(
                    from: route.from,
                    to: route.to,
                    fromCode: route.fromCode,
                    toCode: route.toCode
                )
                .toolbar(.hidden, for: .tabBar)
            }
        }
        .task { await loadCities() }
    }
    
    private func loadCities(force: Bool = false) async {
        guard force || cities.isEmpty else { return }
        do {
            let response = try await APIConfig.allStationsService.getAllStations()
            cities = response.toCities()
            error = nil
        } catch {
            self.error = AppError.from(error)
            print("error:", error)
        }
    }
}

#Preview {
    HomeView()
}
