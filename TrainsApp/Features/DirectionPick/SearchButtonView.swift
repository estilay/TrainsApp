import SwiftUI

struct SearchButtonView: View {
    var action: () -> Void
    
    var body: some View {
        Button("Найти", action: action)
            .font(.system(size: 17, weight: .bold))
            .frame(width: 150, height: 60)
            .background(Color.blueUniversal)
            .foregroundStyle(.whiteUniversal)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    SearchButtonView(action: {})
}
