import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        ZStack {
            Color.whiteDayNight
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Text("Темная тема")
                        .font(.system(size: 17))
                        .foregroundStyle(.blackDayNight)
                    Spacer()
                    Toggle("", isOn: $isDarkMode)
                        .labelsHidden()
                        .tint(.blue)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 19)

                NavigationLink {
                    UserAgreementView()
                } label: {
                    HStack {
                        Text("Пользовательское соглашение")
                            .font(.system(size: 17))
                            .foregroundStyle(.blackDayNight)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(.blackDayNight)
                            .frame(width: 24, height: 24)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 19)
                }

                Spacer()

                VStack(spacing: 16) {
                    Text("Приложение использует API «Яндекс.Расписания»")
                        .font(.system(size: 12))
                        .foregroundStyle(.blackDayNight)
                    Text("Версия 1.0 (beta)")
                        .font(.system(size: 12))
                        .foregroundStyle(.blackDayNight)
                }
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
            .padding(.top, 16)
        }
    }
}

#Preview {
    SettingsView()
}
