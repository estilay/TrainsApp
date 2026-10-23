import SwiftUI

struct InternetErrorView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(.internetError)
                .resizable()
                .frame(width: 223, height: 223)
                .clipShape(RoundedRectangle(cornerRadius: 70))
            Text("Нет интернета")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.blackDayNight)
        }
    }
}

#Preview {
    InternetErrorView()
}
