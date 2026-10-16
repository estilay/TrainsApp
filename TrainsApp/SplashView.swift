import SwiftUI

struct SplashView: View {
    var body: some View {
        Image(.splashScreen)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
