//
//  ViewController.swift
//  WeatherEye
//
//  Created by Cotten Blackwell on 11/7/15.
//  Copyright © 2015 Cotten Blackwell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currentTemperatureLabel: UILabel?
    @IBOutlet weak var currentHumidityLabel: UILabel?
    @IBOutlet weak var currentPrecipitationLabel: UILabel?
    @IBOutlet weak var currentWeatherIcon: UIImageView?
    @IBOutlet weak var currentWeatherSummary: UILabel?
    @IBOutlet weak var refreshButton: UIButton?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    // Location coordinates
    let coordinate: (lat: Double, lon: Double) = (37.8267,-122.423)
    
    // TODO: Enter your API key here
    private let forecastAPIKey = "18c35ade3544374fb5478b45bad9dc8e"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        retrieveWeatherForecast()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retrieveWeatherForecast() {
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(coordinate.lat, lon: coordinate.lon) {
            (let currently) in
            
            if let currentWeather = currently {
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if let temperature = currentWeather.temperature {
                        self.currentTemperatureLabel?.text = "\(temperature)º"
                    }
                    
                    if let humidity = currentWeather.humidity {
                        self.currentHumidityLabel?.text = "\(humidity)%"
                    }
                    
                    if let precipitation = currentWeather.precipProbability {
                        self.currentPrecipitationLabel?.text = "\(precipitation)%"
                    }
                    
                    if let icon = currentWeather.icon {
                        self.currentWeatherIcon?.image = icon
                    }
                    
                    if let summary = currentWeather.summary {
                        self.currentWeatherSummary?.text = summary
                    }
                    
                    self.toggleRefreshAnimation(false)
                    
                }
                
            }
        }
    }
    
    @IBAction func refreshWeather() {
        toggleRefreshAnimation(true)
        retrieveWeatherForecast()
    }
    
    func toggleRefreshAnimation(on: Bool) {
        refreshButton?.hidden = on
        if on {
            activityIndicator?.startAnimating()
        } else {
            activityIndicator?.stopAnimating()
        }
    }
    
    
    
}

