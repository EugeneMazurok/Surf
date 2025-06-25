//
//  CafeCardView.swift
//  surf
//
//  Created by Eugene on 6/24/25.
//

import SwiftUI
import CoreLocation

struct CafeCardView: View {
    let cafe: Cafe
    let userLocation: CLLocation?

    var distanceText: String? {
        guard let userLoc = userLocation else { return nil }
        let cafeLoc = CLLocation(latitude: cafe.latitude, longitude: cafe.longitude)
        let distanceInMeters = userLoc.distance(from: cafeLoc)
        if distanceInMeters < 1000 {
            return "\(Int(distanceInMeters)) м"
        } else {
            return String(format: "%.1f км", distanceInMeters / 1000)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: cafe.imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(height: 120)
                        .frame(maxWidth: .infinity)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 120)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .cornerRadius(12)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 120)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.secondary)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                @unknown default:
                    EmptyView()
                }
            }

            Text(cafe.name)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.5)

            Text(cafe.address)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(1)
                .minimumScaleFactor(0.5)

            if let dist = distanceText {
                Text("Расстояние: \(dist)")
                    .font(.footnote)
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.07), radius: 4, x: 0, y: 2)
    }

    static func formatDistance(_ distance: Double) -> String {
        if distance < 1000 {
            return String(format: "%d м", Int(distance))
        } else {
            return String(format: "%.1f км", distance / 1000)
        }
    }
}
