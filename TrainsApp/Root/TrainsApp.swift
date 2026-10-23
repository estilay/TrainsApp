import SwiftUI

@main
struct TrainsApp: App {
    @State private var showSplash = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                RootTabView()
                
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
