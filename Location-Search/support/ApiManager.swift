//
//  ApiManager.swift
//  Location-Search
//
//  Created by Teyfik Yılmaz on 24.04.2024.
//

import Foundation
final class ApiManager {
    
    static var apiKey : String? {
        get{
            guard let apiKey = "AIzaSyD6dE4su6MOlP1f7fT0KpksHIwpURikgbM" as? String else {
                fatalError("Google Maps API anahtarı eksik veya yanlış konumda")
            }
            return apiKey
        }
    }
    
    
}
