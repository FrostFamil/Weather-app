//
//  WeatherManager.swift
//  Clima
//
//  Created by Famil Samadli on 9/24/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModal);
    func didFailWithError(error: Error);
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=bed5393f2eb2232c266421565a20e539&units=metric";
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)";
        performRequest(urlString: urlString);
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)";
        performRequest(urlString: urlString);
    }
    
    func performRequest(urlString: String) {
        //1. Create url
        if let url = URL(string: urlString) {
            //2. Create url session
            let session = URLSession(configuration: .default)
            
            //3. Give session a task
            //let task = session.dataTask(with: url, completionHandler: handle(data: response: error: ));
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!);
                    return;
                }
                
                if let safeData = data {
                    //let dataString = String(data: safeData, encoding: .utf8);
                    if let weather = self.parseJSON(weatherData: safeData) {
//                        let weatherVC = WeatherViewController();
//                        weatherVC.didUpdateWeather(weather);
                        self.delegate?.didUpdateWeather(self, weather: weather);
                    }
                }
            }
            
            //4. Start the task
            task.resume();
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModal? {
        let decoder = JSONDecoder();
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData);
            let id = decodedData.weather[0].id;
            let temp = decodedData.main.temp;
            let name = decodedData.name;
            
            let weather = WeatherModal(conditionId: id, cityName: name, temperature: temp);
            return weather;
            
        }catch {
            self.delegate?.didFailWithError(error: error);
            return nil;
        }
    }
    
//    func handle(data: Data?, response: URLResponse?, error: Error?) -> Void {
//        if error != nil {
//            print(error!);
//            return;
//        }
//
//        if let safeData = data {
//            let dataString = String(data: safeData, encoding: .utf8);
//            print(dataString!);
//        }
//    }
}
