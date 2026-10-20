import SwiftUI

import SwiftUI

struct RouteCardView: View {
    let route: RouteDisplayModel

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading) {
                HStack(spacing: 8) {
                    if let url = route.carrierLogoURL {
                        AsyncImage(url: url) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                            } else {
                                Image(.brandIcon)
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                        .frame(width: 38, height: 38)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    } else {
                        Image(.brandIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 38, height: 38)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        Text(route.carrierName)
                            .font(.system(size: 17, weight: .regular))
                        if let transferInfo = route.transferInfo, !transferInfo.isEmpty {
                            Text(transferInfo)
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(.redUniversal)
                        }
                    }
                }

                HStack {
                    Text(route.departureTime).font(.system(size: 17, weight: .regular))
                    Rectangle().fill(.grayUniversal).frame(height: 1).frame(maxWidth: .infinity)
                    Text(route.duration).font(.system(size: 12, weight: .regular))
                    Rectangle().fill(.grayUniversal).frame(height: 1).frame(maxWidth: .infinity)
                    Text(route.arrivalTime).font(.system(size: 17, weight: .regular))
                }
            }

            Text(route.dateText)
                .font(.system(size: 12, weight: .regular))
                .padding(.trailing, -7)
        }
        .foregroundStyle(.blackUniversal)
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.lightGrayUniversal))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    RouteCardView(route: RouteDisplayModel(
        id: "1",
        carrierName: "РЖД",
        carrierLogoURL: nil,
        transferInfo: "Пересадка в Костроме",
        departureTime: "22:30",
        arrivalTime: "08:15",
        duration: "9 ч 45 мин",
        dateText: "14 января"
    ))
}
