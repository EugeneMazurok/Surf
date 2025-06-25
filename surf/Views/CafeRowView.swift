//
//  CafeRowView.swift
//  surf
//
//  Created by Eugene on 6/24/25.
//

import SwiftUI
import CoreLocation

struct CafeRowView: View {
    let cafe: Cafe
    let userLocation: CLLocation?

    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: cafe.imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 60, height: 60)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.secondary)
                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(cafe.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                Text(cafe.address)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)

                HStack(spacing: 4) {
                    Image(systemName: "location")
                        .font(.caption2)
                        .foregroundColor(.blue)

                    if let userLocation = userLocation {
                        let distance = CLLocation(latitude: cafe.latitude, longitude: cafe.longitude)
                            .distance(from: userLocation)
                        Text("~" + CafeCardView.formatDistance(distance))
                            .font(.caption2)
                            .foregroundColor(.blue)
                    } else {
                        Text("-")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
            }
            Spacer()
        }
        .padding(.vertical, 6)
    }
}
