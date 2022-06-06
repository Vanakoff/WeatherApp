//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Andrey Vanakoff on 07/06/2022.
//

struct WeatherModel {
    
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionID {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "snow"
        case 700...781:
            return "aqi.low"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "sparkles" // error in names
        }
    }
    
}
