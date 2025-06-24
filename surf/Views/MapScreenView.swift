import SwiftUI
import MapKit
import CoreLocation

struct MapScreenView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 55.75, longitude: 37.61),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    @State private var selectedCafeId: UUID?
    @EnvironmentObject var locationManager: LocationManager
    @Environment(\.colorScheme) var colorScheme
    
    var filteredPromos: [Promo] {
        guard let userCity = locationManager.city?.lowercased() else { return [] }
        return promos.filter { promo in
            promo.cafe.city.lowercased() == userCity
        }
    }

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
            .frame(height: 340)
            .cornerRadius(24)
            .padding([.horizontal, .top])
            .onAppear {
                locationManager.requestLocation()
            }
            .onChange(of: locationManager.location) { newLocation in
                if let coordinate = newLocation?.coordinate {
                    region.center = coordinate
                }
            }
            
            Divider()
                .padding(.vertical, 8)
            
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Акции \(locationManager.city.map { "в \($0)" } ?? "рядом")")
                    .font(.title3.bold())
                    .padding(.horizontal)
                    .foregroundColor(.primary)
                
                if filteredPromos.isEmpty {
                    Text("В вашем городе пока нет доступных акций 🥲")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    ScrollView {
                        VStack(spacing: 14) {
                            ForEach(filteredPromos) { promo in
                                PromoCard(promo: promo)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .padding([.horizontal, .bottom])
                    }
                }
            }
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}
