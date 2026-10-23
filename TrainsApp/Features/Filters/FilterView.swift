import SwiftUI

struct FilterView: View {
    @Binding var isMorningSelected: Bool
    @Binding var isDaySelected: Bool
    @Binding var isEveningSelected: Bool
    @Binding var isNightSelected: Bool
    @Binding var showTransfers: Bool
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.whiteDayNight.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {
                
                VStack(alignment: .leading, spacing: 32) {
                    Text("Время отправления")
                        .font(.system(size: 24, weight: .bold))
                    
                    CheckboxRow(title: "Утро 06:00 - 12:00", isSelected: $isMorningSelected)
                    CheckboxRow(title: "День 12:00 - 18:00", isSelected: $isDaySelected)
                    CheckboxRow(title: "Вечер 18:00 - 00:00", isSelected: $isEveningSelected)
                    CheckboxRow(title: "Ночь 00:00 - 06:00", isSelected: $isNightSelected)
                }
                
                VStack(alignment: .leading, spacing: 32) {
                    Text("Показывать варианты с\nпересадками")
                        .font(.system(size: 24, weight: .bold))
                    
                    RadioRow(title: "Да", isSelected: Binding(
                        get: { showTransfers == true },
                        set: { _ in showTransfers = true }
                    ))
                    
                    RadioRow(title: "Нет", isSelected: Binding(
                        get: { showTransfers == false },
                        set: { _ in showTransfers = false }
                    ))
                }
                Spacer()
                Button("Применить") {
                    dismiss()
                }
                .font(.system(size: 17, weight: .bold))
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(Color.blueUniversal)
                .foregroundStyle(.whiteUniversal)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
            .foregroundStyle(.blackDayNight)
            .font(.system(size: 17, weight: .regular))
            .padding(16)
        }
    }
}

struct CheckboxRow: View {
    let title: String
    @Binding var isSelected: Bool
    
    var body: some View {
        Button(action: {
            isSelected.toggle()
        }) {
            HStack {
                Text(title)
                Spacer()
                Image(isSelected ? .property1CheckBoxStateOn : .property1CheckBoxStateOff)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
    }
}

struct RadioRow: View {
    let title: String
    @Binding var isSelected: Bool
    
    var body: some View {
        Button(action: {
            isSelected = true
        }) {
            HStack {
                Text(title)
                Spacer()
                Image(isSelected ? .property1RadioButtonStateOn : .property1RadioButtonStateOff)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
    }
}

#Preview {
    @Previewable @State var morning = false
    @Previewable @State var day = false
    @Previewable @State var evening = false
    @Previewable @State var night = false
    @Previewable @State var transfers = false
    return NavigationStack {
        FilterView(
            isMorningSelected: $morning,
            isDaySelected: $day,
            isEveningSelected: $evening,
            isNightSelected: $night,
            showTransfers: $transfers
        )
    }
}
