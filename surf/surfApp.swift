//
//  surfApp.swift
//  surf
//
//  Created by Eugene on 6/24/25.
//

import SwiftUI

@main
struct surfApp: App {
    
    @StateObject private var locationManager = LocationManager()
    @StateObject private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(locationManager)
                .environmentObject(themeManager)
                .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
                .onAppear {
                    locationManager.requestLocation()
                }
        }
    }
}
