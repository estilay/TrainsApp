import Foundation

enum AppConfig {
    static var secretAPIKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "SECRET_API_KEY") as? String,
              !key.isEmpty,
              !key.hasPrefix("$(") else {
            fatalError("SECRET_API_KEY not found in Info.plist. Check Secrets.xcconfig binding.")
        }
        return key
    }
}
