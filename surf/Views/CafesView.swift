import SwiftUI
import CoreLocation

struct CafesView: View {
    @State private var selectedCity = "Все"
    @State private var isGridView = true
    @State private var userLocation: CLLocation? = nil
    @EnvironmentObject var locationManager: LocationManager
    @State private var showLocationAlert = false
    @Environment(\.colorScheme) var colorScheme
    @Namespace private var animation

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
                            Button(action: {
                                withAnimation(.spring()) {
                                    selectedCity = city
                                }
                            }) {
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
                            withAnimation(.easeInOut(duration: 0.3)) {
                                locationManager.requestLocation()
                            }
                        }) {
                            Image(systemName: "arrow.clockwise")
                                .font(.title2)
                                .padding(10)
                                .background(Color(.tertiarySystemBackground))
                                .clipShape(Circle())
                        }
                        Button(action: {
                            withAnimation(.easeInOut) {
                                isGridView.toggle()
                            }
                        }) {
                            Image(systemName: isGridView ? "list.bullet" : "square.grid.2x2")
                                .font(.title2)
                                .padding(10)
                                .background(Color(.tertiarySystemBackground))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.trailing)
                }
                .padding(.vertical, 8)

                // Сноска про сортировку
                Text("Список автоматически отсортирован по расстоянию до ближайшей кофейни.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom, 4)

                Divider()

                if isGridView {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150, maximum: 200))], spacing: 16) {
                            ForEach(filteredCafes) { cafe in
                                CafeCardView(cafe: cafe, userLocation: userLocation)
                                    .frame(width: 180, height: 240)
                                    .transition(.opacity.combined(with: .scale))
                            }
                        }
                        .padding()
                    }
                } else {
                    List(filteredCafes) { cafe in
                        CafeRowView(cafe: cafe, userLocation: userLocation)
                            .listRowBackground(Color(.secondarySystemBackground))
                    }
                    .listStyle(PlainListStyle())
                }

                // Сноска про картинки — внизу
                Text("В целях экономии трафика отображаются картинки только кофеен вашего города.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top, 4)
                    .padding(.bottom, 8)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color(.systemBackground), Color(.secondarySystemBackground)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
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
