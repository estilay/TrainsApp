import SwiftUI

struct CityPickerView: View {
    let cities: [CityModel]
    var onSelect: (CityModel) -> Void
    
    @State private var searchText = ""
    
    private var filtered: [CityModel] {
        searchText.isEmpty ? cities : cities.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(filtered) { city in
                    row(city.title)
                        .onTapGesture { onSelect(city) }
                }
            }
        }
        .overlay {
            if filtered.isEmpty && !searchText.isEmpty {
                Text("Город не найден")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.blackDayNight)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.whiteDayNight.ignoresSafeArea())
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Введите запрос")
        .navigationTitle("Выбор города")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func row(_ title: String) -> some View {
        HStack {
            Text(title).font(.system(size: 17))
            Spacer()
            Image(systemName: "chevron.right")
                .frame(width: 24, height: 24)
                .foregroundStyle(.blackDayNight)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 18)
        .contentShape(Rectangle())
    }
}

#Preview {
    NavigationStack {
        CityPickerView(cities: [
            CityModel(title: "Москва", yandexCode: nil, stations: []),
            CityModel(title: "Санкт-Петербург", yandexCode: nil, stations: [])
        ]) { _ in }
    }
}
