//
//  WeatherManager.swift
//  Clima
//
//  Created by Apple Multiplier on 20/01/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

protocol WheatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WheatherManager,weather: WeatherModel)
    func didFailError(error: Error)
}

struct WheatherManager {
    let url = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=54cb8be399c36db1c6ebf335db6a6293"
    
    func fetchWeather(cityName: String){
        let urlString = "\(url)&q=\(cityName)"
        self.dataRequest(url: urlString)
    }
    
    var delegate: WheatherManagerDelegate?
    
    func dataRequest(url: String){
        if let initialUrl = URL(string: url){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: initialUrl) { data, response, error in
                if error != nil {
                    self.delegate?.didFailError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJson(weatherData: safeData){
                        self.delegate?.didUpdateWeather(self,weather: weather)
                    }
                }
            }
            
            task.resume()
            
        }
    }
    
    func parseJson(weatherData: Data)-> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            
          let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
          
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(
            conditionId: id, cityName: name, temperature: temp)
            return weather
        } catch{
            delegate?.didFailError(error: error)
            return nil
        }
    }
    
    
}
