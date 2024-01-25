//
//  WeatherModel.swift
//  Clima
//
//  Created by Apple Multiplier on 24/01/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
            case 200...232:
                return "could.bolt"
            case 300...321:
                return "could.drizzle"
            case 500...531:
                return "could.rain"
            case 600...622:
                return "could.snow"
            case 701...781:
                return "could.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "could.bolt"
            default:
                return "could"
                
        }
    }
}
