//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Andrey Vanakoff on 07/06/2022.
//

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric"
    let apikey = "&appid=392b31e8189022ab1813cfeb9b7146a9"
    
    func fetchWeather(cityName: String) {
        let urlSring = "\(weatherURL)\(apikey)&q=\(cityName)"
        print(urlSring)
    }
    
}
