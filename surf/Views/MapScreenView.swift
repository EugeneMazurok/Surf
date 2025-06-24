//
//  MapScreenView.swift
//  surf
//
//  Created by Eugene on 6/24/25.
//

import SwiftUI
import MapKit

struct MapScreenView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 55.7558, longitude: 37.6176), // Центр Москвы
        span: MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4)
    )
    
    @State private var selectedCafeId: UUID?
    
    var body: some View {
        VStack(spacing: 0) {
            Map(coordinateRegion: $region, annotationItems: cafesData) { cafe in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: cafe.latitude, longitude: cafe.longitude)) {
                    Button(action: {
                        selectedCafeId = cafe.id
                        withAnimation {
                            region.center = CLLocationCoordinate2D(latitude: cafe.latitude, longitude: cafe.longitude)
                        }
                    }) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(selectedCafeId == cafe.id ? .blue : .red)
                            .font(.title2)
                    }
                }
            }
            .frame(height: 350)
            .cornerRadius(20)
            .padding([.horizontal, .top])
            
            Text("Все кофейни")
                .font(.title3.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 8)
            
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(cafesData) { cafe in
                            CafeCardsView(cafe: cafe)
                                .id(cafe.id)
                                .onTapGesture {
                                    selectedCafeId = cafe.id
                                    withAnimation {
                                        region.center = CLLocationCoordinate2D(latitude: cafe.latitude, longitude: cafe.longitude)
                                        proxy.scrollTo(cafe.id, anchor: .center)
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, 16)
        }
    }
}

struct CafeCardsView: View {
    let cafe: Cafe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(cafe.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 120)
                .clipped()
                .cornerRadius(12)
            
            Text(cafe.name)
                .font(.headline)
                .lineLimit(1)
            
            Text("\(cafe.city), \(cafe.address)")
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(2)
            
            Text("🎁 Первый кофе бесплатно утром!")
                .font(.footnote)
                .foregroundColor(.green)
            
            Button("Открыть в картах") {
                let url = URL(string: "http://maps.apple.com/?ll=\(cafe.latitude),\(cafe.longitude)")!
                UIApplication.shared.open(url)
            }
            .font(.caption)
            .foregroundColor(.blue)
        }
        .padding()
        .frame(width: 250)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
                .shadow(radius: 2)
        )
    }
}
