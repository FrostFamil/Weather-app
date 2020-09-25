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
            getConditionName(weatherId: id);
        }catch {
            print(error);
        }
    }
    
    func getConditionName(weatherId: Int) -> String{
        switch weatherId {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
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
