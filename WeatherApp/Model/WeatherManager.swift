//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Andrey Vanakoff on 07/06/2022.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric"
    let apikey = "&appid=392b31e8189022ab1813cfeb9b7146a9"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlSring = "\(weatherURL)\(apikey)&q=\(cityName)"
        performRequest(with: urlSring)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)\(apikey)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //1.Create URL
        if let url = URL(string: urlString) {
            //2.Create a URLSession
            let session = URLSession(configuration: .default)
            //3.Give Session a Task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    //let dataString = String(data: safeData, encoding: .utf8)
                    if let weather = parseJSON(safeData) {
                        // let weatherVC = WeatherViewController()
                        // weatherVC.didUpdateWeather(weather: weather)
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //4.Start the Task
            task.resume()
        }
        
        func parseJSON(_ weatherData: Data) -> WeatherModel? {
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
                let id = decodedData.weather[0].id
                let temp = decodedData.main.temp
                let name = decodedData.name
                
                let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
        
                return weather
                // print(weather.conditionName)
                // print(weather.temperatureString)
                
            } catch {
                delegate?.didFailWithError(error: error)
                return nil
            }
        }
    }
}
