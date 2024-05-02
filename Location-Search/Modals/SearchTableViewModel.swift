//
//  SearchTableViewModel.swift
//  Location-Search
//
//  Created by Teyfik Yılmaz on 24.04.2024.
//

import Foundation

import UIKit

struct SearchTableViewModel {
    var locationName: String
    var distance: String

    // Default initializer
    init() {
        self.locationName = "lo"
        self.distance = "lo"
    }

    // Parameterized initializer
    init(locationName: String, distance: String) {
        self.locationName = locationName
        self.distance = distance
    }
}
