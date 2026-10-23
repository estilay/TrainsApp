import SwiftUI

struct ErrorStateView: View {
    let error: AppError
    var onRetry: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            switch error {
            case .internet: InternetErrorView()
            case .server:   ServerErrorView()
            }
            Button("Повторить", action: onRetry)
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(.blueUniversal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.whiteDayNight.ignoresSafeArea())
    }
}
