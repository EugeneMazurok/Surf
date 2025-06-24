//
//  Promo.swift
//  surf
//
//  Created by Eugene on 6/24/25.
//

import Foundation

struct Promo: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let cafe: Cafe
}
