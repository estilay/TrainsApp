import SwiftUI

struct ServerErrorView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(.serverError)
                .resizable()
                .frame(width: 223, height: 223)
                .clipShape(RoundedRectangle(cornerRadius: 70))
            Text("Ошибка сервера")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.blackDayNight)
        }
    }
}

#Preview {
    ServerErrorView()
}
