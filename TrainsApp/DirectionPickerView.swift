import SwiftUI

struct DirectionPickerView: View {
    var from: String
    var to: String
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 28) {
                Text(from.isEmpty ? "Откуда" : from)
                    .foregroundStyle(from.isEmpty ? Color(.grayUniversal) : .primary)
                    .padding(.horizontal, 16)
                Text(to.isEmpty ? "Куда" : to)
                    .foregroundStyle(to.isEmpty ? Color(.grayUniversal): .primary)
                    .padding(.horizontal, 16)
            }
            .frame(width: 259, height: 96, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
            )
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Button("", image: .сhange) {
                
            }
        }
        .frame(width: 343, height: 128)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.blueUniversal)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    DirectionPickerView(from: "", to: "")
}
