import SwiftUI
import WebKit

struct UserAgreementView: View {
    private let urlString = "https://yandex.ru/legal/rasp_api/ru/"

    var body: some View {
        ZStack {
            Color.whiteDayNight
                .ignoresSafeArea()

            if let url = URL(string: urlString) {
                WebView(url: url)
                    .ignoresSafeArea(edges: .bottom)
                    .navigationTitle("Пользовательское соглашение")
                    .navigationBarTitleDisplayMode(.inline)
            } else {
                Text("Не удалось загрузить страницу")
                    .foregroundStyle(.blackDayNight)
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        if webView.url != url {
            webView.load(URLRequest(url: url))
        }
    }
}

#Preview {
    NavigationStack {
        UserAgreementView()
    }
}
