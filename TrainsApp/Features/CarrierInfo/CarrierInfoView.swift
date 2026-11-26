import SwiftUI

struct CarrierInfoView: View {
    let route: CarrierInfoRoute
    
    @State private var carrier: CarrierResponse?
    @State private var isLoading = false
    @State private var error: AppError?
    
    var body: some View {
        ZStack {
            Color.whiteDayNight.ignoresSafeArea()
            
            if isLoading {
                SpinnerProgressView()
            } else if let error {
                ErrorStateView(error: error) {
                    Task { await loadCarrier(force: true) }
                }
            } else {
                VStack(alignment: .leading, spacing: 16) {
                    logoBlock
                        .padding(.horizontal, 16)
                    
                    Text(carrier?.carrier?.title ?? route.carrierName)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.blackDayNight)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                    
                    contactsBlock
                        .padding(.horizontal, 16)
                    
                    Spacer()
                }
                .padding(.top, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .navigationTitle("Информация о перевозчике")
        .navigationBarTitleDisplayMode(.inline)
        .task { await loadCarrier() }
    }
    
    // MARK: - Logo
    private var logoBlock: some View {
        Color.clear
            .frame(maxWidth: .infinity)
            .frame(height: 104)
            .overlay {
                AsyncImage(url: logoURL) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else {
                        placeholderLogo
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .contentShape(RoundedRectangle(cornerRadius: 24))
    }
    
    private var logoURL: URL? {
        if let apiLogo = carrier?.carrier?.logo,
           let url = URL(string: apiLogo) {
            return url
        }
        return route.carrierLogoURL
    }
    
    private var placeholderLogo: some View {
        Image(.brandIcon)
            .resizable()
            .scaledToFit()
            .padding(12)
    }
    
    // MARK: - Contacts
    private var contactsBlock: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let email = carrier?.carrier?.email, !email.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    Text("E-mail")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.blackDayNight)
                    
                    if let url = emailURL(email) {
                        Link(destination: url) {
                            Text(email)
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(.blueUniversal)
                                .multilineTextAlignment(.leading)
                        }
                    } else {
                        Text(email)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.blackDayNight)
                    }
                }
            }
            
            if let phone = carrier?.carrier?.phone, !phone.isEmpty {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Телефон")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.blackDayNight)
                    
                    if let url = phoneURL(phone) {
                        Link(destination: url) {
                            Text(phone)
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(.blueUniversal)
                                .multilineTextAlignment(.leading)
                        }
                    } else {
                        Text(phone)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.blackDayNight)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - Helpers
    private func phoneURL(_ phone: String) -> URL? {
        let cleaned = phone.filter { $0.isNumber || $0 == "+" }
        guard !cleaned.isEmpty else { return nil }
        return URL(string: "tel:\(cleaned)")
    }
    
    private func emailURL(_ email: String) -> URL? {
        let trimmed = email.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }
        return URL(string: "mailto:\(trimmed)")
    }
    
    // MARK: - Loading
    private func loadCarrier(force: Bool = false) async {
        guard force || carrier == nil else { return }
        guard !route.carrierCode.isEmpty else { return }
        
        isLoading = true
        defer { isLoading = false }
        error = nil
        
        do {
            carrier = try await APIConfig.carrierInfoService.getCarrierInfo(
                code: route.carrierCode,
                system: route.carrierSystem
            )
        } catch {
            self.error = AppError.from(error)
            print("carrier error:", error)
        }
    }
}

#Preview {
    NavigationStack {
        CarrierInfoView(
            route: CarrierInfoRoute(
                carrierCode: "123",
                carrierSystem: nil,
                carrierName: "Аэрофлот",
                carrierLogoURL: nil
            )
        )
    }
}
