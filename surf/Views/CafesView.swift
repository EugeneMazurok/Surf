//
//  CafesView.swift
//  surf
//
//  Created by Eugene on 6/24/25.
//

import SwiftUI
import CoreLocation

let cafesData: [Cafe] = [
    Cafe(name: "Surf Coffee Garden", address: "ул. Большая Садовая, 81/31", city: "Ростов-на-Дону", imageName: "rostov_garden", latitude: 47.222078, longitude: 39.720349),
    Cafe(name: "Surf Coffee Soborniy", address: "пер. Соборный, 28/45", city: "Ростов-на-Дону", imageName: "rostov_soborniy", latitude: 47.222876, longitude: 39.720965),
    Cafe(name: "Surf Coffee Astor", address: "Будённовский просп., 49/97", city: "Ростов-на-Дону", imageName: "rostov_astor", latitude: 47.225295, longitude: 39.720703),
    Cafe(name: "Surf Coffee ASP", address: "ул. Пушкинская, 112", city: "Ростов-на-Дону", imageName: "rostov_asp", latitude: 47.225800, longitude: 39.718900),
    Cafe(name: "Surf Coffee Right Coast", address: "ул. Береговая, 12/1", city: "Ростов-на-Дону", imageName: "rostov_rightcoast", latitude: 47.222500, longitude: 39.710000),
    Cafe(name: "Surf Coffee Arbat", address: "ул. Новый Арбат, 7а", city: "Москва", imageName: "moscow_arbat", latitude: 55.752220, longitude: 37.586870),
    Cafe(name: "Surf Coffee Solyanka", address: "ул. Солянка, 1/2", city: "Москва", imageName: "moscow_solyanka", latitude: 55.752023, longitude: 37.639110),
    Cafe(name: "Surf Coffee Secret Spot", address: "ул. Конный переулок, 12", city: "Москва", imageName: "moscow_secretspot", latitude: 55.723000, longitude: 37.610000),
    Cafe(name: "Surf Coffee Lips", address: "ул. Дмитрия Ульянова, 4к1", city: "Москва", imageName: "moscow_lips", latitude: 55.691000, longitude: 37.573000),
    Cafe(name: "Surf Coffee G-Spot", address: "ул. Мясницкая, 16", city: "Москва", imageName: "moscow_gspot", latitude: 55.764000, longitude: 37.638000),
    Cafe(name: "Surf Coffee Mayak", address: "ул. Тверская, 25/12", city: "Москва", imageName: "moscow_mayak", latitude: 55.765000, longitude: 37.604000),
    Cafe(name: "Surf Coffee Shore", address: "МКАД 66 км, Крокус Сити Молл", city: "Москва", imageName: "moscow_shore", latitude: 55.823000, longitude: 37.388000),
    Cafe(name: "Surf Coffee Dream", address: "ул. Новослободская, 16а", city: "Москва", imageName: "moscow_dream", latitude: 55.781000, longitude: 37.601000),
    Cafe(name: "Surf Coffee Anthill", address: "Пресненская наб., 12", city: "Москва", imageName: "moscow_anthill", latitude: 55.749000, longitude: 37.539000),
    Cafe(name: "Surf Coffee Change", address: "Стремянный пер., 38", city: "Москва", imageName: "moscow_change", latitude: 55.726000, longitude: 37.624000),
    Cafe(name: "Surf Coffee G34", address: "ул. Гороховая, 34", city: "Санкт-Петербург", imageName: "spb_g34", latitude: 59.927000, longitude: 30.321000),
    Cafe(name: "Surf Coffee Jetlag", address: "Малая Конюшенная, 7", city: "Санкт-Петербург", imageName: "spb_jetlag", latitude: 59.936000, longitude: 30.322000),
    Cafe(name: "Surf Coffee MDT", address: "ул. Рубинштейна, 9/3", city: "Санкт-Петербург", imageName: "spb_mdt", latitude: 59.929000, longitude: 30.347000),
    Cafe(name: "Surf Coffee Soul", address: "Средний пр. В.О., 27", city: "Санкт-Петербург", imageName: "spb_soul", latitude: 59.942000, longitude: 30.278000),
    Cafe(name: "Surf Coffee Lev Tolstoy", address: "ул. Льва Толстого, 1-3", city: "Санкт-Петербург", imageName: "spb_tolstoy", latitude: 59.966000, longitude: 30.311000),
    Cafe(name: "Surf Coffee Basque", address: "Басков пер., 6", city: "Санкт-Петербург", imageName: "spb_basque", latitude: 59.934000, longitude: 30.353000),
    Cafe(name: "Surf Coffee Chizhik", address: "ул. Пестеля, 13-15", city: "Санкт-Петербург", imageName: "spb_chizhik", latitude: 59.936000, longitude: 30.349000)
]

struct CafesView: View {
    @State private var selectedCity = "Все"
    @State private var isGridView = true
    @State private var userLocation: CLLocation? = nil
    @StateObject private var locationManager = LocationManager()
    @State private var showLocationAlert = false
    
    private let cities = ["Все", "Ростов-на-Дону", "Санкт-Петербург", "Москва"]
    
    var filteredCafes: [Cafe] {
        let cafes = selectedCity == "Все" ? cafesData : cafesData.filter { $0.city == selectedCity }
        if let userLocation = userLocation {
            return cafes.sorted {
                let loc1 = CLLocation(latitude: $0.latitude, longitude: $0.longitude)
                let loc2 = CLLocation(latitude: $1.latitude, longitude: $1.longitude)
                return userLocation.distance(from: loc1) < userLocation.distance(from: loc2)
            }
        } else {
            return cafes
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(cities, id: \.self) { city in
                            Button(action: { selectedCity = city }) {
                                Text(city)
                                    .font(.subheadline.bold())
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(selectedCity == city ? Color.blue.opacity(0.15) : Color.clear)
                                    .foregroundColor(selectedCity == city ? .blue : .primary)
                                    .cornerRadius(16)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                }
                
                HStack {
                    Text("Кофейни")
                        .font(.largeTitle.bold())
                        .padding(.leading)
                    Spacer()
                    HStack(spacing: 8) {
                        Button(action: {
                            locationManager.requestLocation()
                        }) {
                            Image(systemName: "arrow.clockwise")
                                .font(.title2)
                                .padding(10)
                                .background(Color(.systemGray6))
                                .clipShape(Circle())
                        }
                        Button(action: { isGridView.toggle() }) {
                            Image(systemName: isGridView ? "list.bullet" : "square.grid.2x2")
                                .font(.title2)
                                .padding(10)
                                .background(Color(.systemGray6))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.trailing)
                }
                .padding(.vertical, 8)
                
                Divider()
                
                if isGridView {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 180, maximum: 200))], spacing: 16) {
                            ForEach(filteredCafes) { cafe in
                                CafeCardView(cafe: cafe, userLocation: userLocation)
                                    .frame(width: 180, height: 240)
                            }
                        }
                        .padding()
                    }
                } else {
                    List(filteredCafes) { cafe in
                        CafeRowView(cafe: cafe, userLocation: userLocation)
                            .listRowBackground(Color(.systemGray6))
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.07)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            )
            .onAppear {
                locationManager.requestLocation()
                if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted {
                    showLocationAlert = true
                }
            }
            .onReceive(locationManager.$location) { loc in
                self.userLocation = loc
            }
            .onReceive(locationManager.$city) { city in
                if let city = city, selectedCity == "Все", cities.contains(city) {
                    selectedCity = city
                }
            }
            .alert(isPresented: $showLocationAlert) {
                Alert(
                    title: Text("Геолокация отключена"),
                    message: Text("Для отображения расстояния до кофеен разрешите доступ к геолокации в настройках."),
                    dismissButton: .default(Text("Ок"))
                )
            }
        }
    }
}

struct CafeCardView: View {
    let cafe: Cafe
    let userLocation: CLLocation?

    var body: some View {
        VStack(spacing: 8) {
            Image(cafe.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 160, height: 120)
                .clipped()
                .cornerRadius(10)
            Text(cafe.name)
                .font(.headline)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(height: 40)
            Text(cafe.address)
                .font(.caption)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            HStack(spacing: 4) {
                Image(systemName: "location")
                    .font(.caption2)
                    .foregroundColor(.blue)
                if let userLocation = userLocation {
                    let distance = CLLocation(latitude: cafe.latitude, longitude: cafe.longitude).distance(from: userLocation)
                    Text("~" + CafeCardView.formatDistance(distance))
                        .font(.caption2)
                        .foregroundColor(.blue)
                } else {
                    Text("-")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(8)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.opacity(0.95))
        .cornerRadius(14)
        .shadow(color: Color.blue.opacity(0.08), radius: 4, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.blue.opacity(0.12), lineWidth: 1)
        )
    }

    static func formatDistance(_ distance: Double) -> String {
        if distance < 1000 {
            return String(format: "%d м", Int(distance))
        } else {
            return String(format: "%.1f км", distance / 1000)
        }
    }
}

struct CafeRowView: View {
    let cafe: Cafe
    let userLocation: CLLocation?

    var body: some View {
        HStack(spacing: 16) {
            Image(cafe.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            VStack(alignment: .leading, spacing: 4) {
                Text(cafe.name).font(.headline)
                Text(cafe.address).font(.caption).foregroundColor(.gray)
                HStack(spacing: 4) {
                    Image(systemName: "location")
                        .font(.caption2)
                        .foregroundColor(.blue)
                    if let userLocation = userLocation {
                        let distance = CLLocation(latitude: cafe.latitude, longitude: cafe.longitude).distance(from: userLocation)
                        Text("~" + CafeCardView.formatDistance(distance)).font(.caption2).foregroundColor(.blue)
                    } else {
                        Text("-").font(.caption2).foregroundColor(.gray)
                    }
                }
            }
            Spacer()
        }
        .padding(.vertical, 6)
    }
}

// MARK: - Location Manager with Reverse Geocoding

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var location: CLLocation? = nil
    @Published var city: String? = nil

    private let manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.first {
            location = loc
            updateCity(from: loc)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }

    private func updateCity(from location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let cityName = placemarks?.first?.locality {
                DispatchQueue.main.async {
                    self.city = cityName
                }
            }
        }
    }
}
