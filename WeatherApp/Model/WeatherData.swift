//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Andrey Vanakoff on 07/06/2022.
//

struct WeatherData: Codable {
    
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
