import SwiftUI

struct FilterButtonView: View {
    let isActive: Bool
    
    var body: some View {
        HStack(spacing: 4) {
            Text("Уточнить время")
                .font(.system(size: 17, weight: .bold))
            
            if isActive {
                Circle()
                    .fill(.redUniversal)
                    .frame(width: 8, height: 8)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(Color.blueUniversal)
        .foregroundStyle(.whiteUniversal)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
}

#Preview {
    VStack {
        FilterButtonView(isActive: false)
        FilterButtonView(isActive: true)
    }
}
