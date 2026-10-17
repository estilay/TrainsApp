import SwiftUI

struct HomeView: View {
    @State private var from = ""
    @State private var to = ""
    @State private var path = NavigationPath()
    @State private var cities: [CityModel] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    enum PickField: Hashable { case from, to }
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color.whiteDayNight.ignoresSafeArea()
                
                if isLoading {
                    ProgressView()
                } else if let errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .padding()
                } else {
                    DirectionPickerView(
                        from: $from,
                        to: $to,
                        onSelectFrom: { path.append(PickField.from) },
                        onSelectTo:   { path.append(PickField.to) }
                    )
                }
            }
            .navigationDestination(for: PickField.self) { field in
                CityPickerView(cities: cities) { city in
                    path.append(StationRoute(field: field, city: city))
                }
            }
            .navigationDestination(for: StationRoute.self) { route in
                StationPickerView(
                    cityTitle: route.city.title,
                    stations: route.city.stations
                ) { station in
                    let value = "\(route.city.title), \(station.title)"
                    switch route.field {
                    case .from: from = value
                    case .to:   to   = value
                    }
                    
                    var transaction = Transaction()
                    transaction.disablesAnimations = true
                    withTransaction(transaction) {
                        path = NavigationPath()
                    }
                }
            }
        }
        .task { await loadCities() }
    }
    
    private func loadCities() async {
        guard cities.isEmpty else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            let response = try await APIConfig.allStationsService.getAllStations()
            cities = response.toCities()
        } catch {
            errorMessage = "Ошибка: \(error.localizedDescription)"
        }
    }
}

struct StationRoute: Hashable {
    let field: HomeView.PickField
    let city: CityModel
}

#Preview {
    HomeView()
}
