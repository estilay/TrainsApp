import SwiftUI 

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.whiteDayNight
                .ignoresSafeArea()
            DirectionPickerView(from: "", to: "")
        }
    }
}

#Preview {
    HomeView()
}
