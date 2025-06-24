//
//  PromoCard.swift
//  surf
//
//  Created by Eugene on 6/24/25.
//

import SwiftUI

struct PromoCard: View {
    let promo: Promo
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 12) {
                Image(systemName: "gift.fill")
                    .font(.title2)
                    .foregroundColor(.red)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(promo.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(promo.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            Divider()
                .background(Color(.separator))
            
            HStack {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(Color(.secondaryLabel))
                Text(promo.cafe.name)
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.3 : 0.05), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.red.opacity(0.15), lineWidth: 1)
        )
    }
}
