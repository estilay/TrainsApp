import SwiftUI

struct StationPickerView: View {
    let cityTitle: String
    let stations: [StationModel]
    var onSelect: (StationModel) -> Void

    @State private var searchText = ""
    @Environment(\.dismiss) private var dismiss

    private var filtered: [StationModel] {
        searchText.isEmpty ? stations : stations.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(Array(filtered.enumerated()), id: \.offset) { _, station in
                    row(station.title)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            onSelect(station)
                            dismiss()
                        }
                }
            }
        }
        .overlay {
            if filtered.isEmpty && !searchText.isEmpty {
                Text("Станция не найдена")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.blackDayNight)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.whiteDayNight.ignoresSafeArea())
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Введите запрос"
        )
        .navigationTitle(cityTitle)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func row(_ title: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 17))
            Spacer()
            Image(systemName: "chevron.right")
                .frame(width: 24, height: 24)
                .foregroundStyle(.blackDayNight)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 19)
    }
}

#Preview {
    NavigationStack {
        StationPickerView(
            cityTitle: "Москва",
            stations: [
                StationModel(title: "Курский вокзал", yandexCode: nil),
                StationModel(title: "Ленинградский вокзал", yandexCode: nil)
            ]
        ) { _ in }
    }
}
