import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            HomeView()
            .tabItem {
                Label("", image: .schedule)
            }
            SettingsView()
            .tabItem {
                Label("", image: .settings)
            }
        }
        .tint(.blackDayNight)
    }
}

#Preview {
    RootTabView()
}
