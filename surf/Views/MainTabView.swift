//
//  MainTabView.swift
//  surf
//
//  Created by Eugene on 6/24/25.
//

import Foundation
import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 1

    var body: some View {
        TabView(selection: $selectedTab) {
        CafesView()
            .tabItem {
                Label("Кофейни", systemImage: "mappin.and.ellipse")
            }
            .tag(0)

        HomeView()
            .tabItem {
                Label("Главная", systemImage: "house")
            }
            .tag(1)

        MapScreenView()
            .tabItem {
                Label("Карта", systemImage: "map")
            }
            .tag(2)
        }
    }
}
