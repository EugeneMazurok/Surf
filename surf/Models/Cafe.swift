//
//  Cafe.swift
//  surf
//
//  Created by Eugene on 6/24/25.
//

import Foundation

struct Cafe: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let city: String
    let imageURL: URL
    let latitude: Double
    let longitude: Double
}
