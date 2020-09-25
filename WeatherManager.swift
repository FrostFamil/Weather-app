//
//  WeatherManager.swift
//  Clima
//
//  Created by Famil Samadli on 9/24/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=bed5393f2eb2232c266421565a20e539&units=metric";
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)";
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
                    print(error!);
                    return;
                }
                
                if let safeData = data {
                    //let dataString = String(data: safeData, encoding: .utf8);
                    self.parseJSON(weatherData: safeData);
                }
            }
            
            //4. Start the task
            task.resume();
        }
    }
    
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder();
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData);
            let id = decodedData.weather[0].id;
            let temp = decodedData.main.temp;
            let name = decodedData.name;
            
            let weather = WeatherModal(conditionId: id, cityName: name, temperature: temp);
            print(weather.conditionName);
        }catch {
            print(error);
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
