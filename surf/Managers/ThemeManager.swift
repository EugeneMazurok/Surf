//
//  ThemeManager.swift
//  surf
//
//  Created by Eugene on 6/24/25.
//

import SwiftUI

class ThemeManager: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
}
