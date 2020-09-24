//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self;
    }


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
        textField.text = "";
    }
}

