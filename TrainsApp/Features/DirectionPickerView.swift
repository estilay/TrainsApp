import SwiftUI

struct DirectionPickerView: View {
    @Binding var from: String
    @Binding var to: String
    var onSelectFrom: () -> Void
    var onSelectTo: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 28) {
                Text(from.isEmpty ? "Откуда" : from)
                    .foregroundStyle(from.isEmpty ? Color(.grayUniversal) : Color(.blackUniversal))
                    .padding(.horizontal, 16)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
                    .onTapGesture { onSelectFrom() }
                
                Text(to.isEmpty ? "Куда" : to)
                    .foregroundStyle(to.isEmpty ? Color(.grayUniversal) : Color(.blackUniversal))
                    .padding(.horizontal, 16)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
                    .onTapGesture { onSelectTo() }
            }
            .frame(width: 259, height: 96, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 20).fill(.white))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Button("", image: .сhange) {
                (from, to) = (to, from)
            }
        }
        .frame(width: 343, height: 128)
        .background(RoundedRectangle(cornerRadius: 20).fill(.blueUniversal))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    @Previewable @State var from = ""
    @Previewable @State var to = ""
    DirectionPickerView(from: $from, to: $to, onSelectFrom: {}, onSelectTo: {})
}
