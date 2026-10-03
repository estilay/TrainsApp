import SwiftUI

@main
struct TrainsAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    await smokeCheckAll()
                }
        }
    }
}
