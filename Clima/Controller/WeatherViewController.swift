//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager();
    let locationManager = CLLocationManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.delegate = self; // use before
        locationManager.requestWhenInUseAuthorization();
        locationManager.requestLocation();
        
        weatherManager.delegate = self;
        searchTextField.delegate = self;
    }
    
    
    @IBAction func locationButtonPress(_ sender: UIButton) {
        locationManager.requestLocation();
    }
}


//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true);
    }
    
    //keyboard return button pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.endEditing(true);
        return true;
    }
    
    //Runs when user clicks somewhere else in the app
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true;
        }else {
            textField.placeholder = "Type something here";
            return false;
        }
    }
    
    //Runs after user done with editing text field
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city);
        }
        
        textField.text = "";
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModal) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString;
            self.conditionImageView.image = UIImage(systemName: weather.conditionName);
            self.cityLabel.text = weather.cityName;
        }
    }
    
    func didFailWithError(error: Error) {
        print(error);
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation();
            let lat = location.coordinate.latitude;
            let lon = location.coordinate.longitude;
            weatherManager.fetchWeather(latitude: lat, longitude: lon);
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error);
    }
}
