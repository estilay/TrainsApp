import SwiftUI

@main
struct TrainsApp: App {
    @State private var showSplash = true
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                RootTabView()
                    .preferredColorScheme(isDarkMode ? .dark : .light)
                if showSplash {
                    SplashView()
                        .transition(.opacity)
                }
            }
            .animation(.easeOut(duration: 0.4), value: showSplash)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    showSplash = false
                }
            }
        }
    }
}
