//
//  WeatherManager.swift
//  Clima
//
//  Created by Famil Samadli on 9/24/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?&appid=bed5393f2eb2232c266421565a20e539&units=metric";
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)";
    }
}
