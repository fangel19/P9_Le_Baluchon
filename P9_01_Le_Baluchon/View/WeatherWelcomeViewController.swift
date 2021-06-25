//
//  WeatherWelcomeViewController.swift
//  P9_01_Le_Baluchon
//
//  Created by angelique fourny on 11/06/2021.
//

import UIKit

class WeatherWelcomeViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var tempWeather: UILabel!
    @IBOutlet weak var iconWeather: UIImageView!
    @IBOutlet weak var descriptionWeather: UILabel!
    
    @IBOutlet weak var cityText: UITextField!
    
    private var cities = [String]()
    
    //    private var usersArray: [WeatherInfo]? {
    //        didSet {
    //            DispatchQueue.main.async {
    //                self.cityText.reloadInputViews()
    //            }
    //        }
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateWeather()
        
    }
    @IBAction func validation(_ sender: Any) {
        updateWeather()
    }
    
    private func updateWeather() {
        WeatherService.shared.getWeather(city: "New York") { result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self.viewWeather(info: weather)
                    print(weather)
                }
//                self.viewWeather(info: weather[0])
                
                //                self.viewWeather(info: weather[0])
                print("=> success")
            case .failure(let error):
                print(error.localizedDescription)
            //                self.alertMessage(with: "error")
            }
        }
    }
    
    //    WeatherInfo.init(weather: [WeatherElement.init(description: "nuageux", Icon: "04d")], main: Main.init(temp: 24.29), name: "Paris")
    //    //        viewWeather()
    
    private func viewWeather(info: WeatherInfo) {
        tempWeather.text = String(info.main.temp)
        descriptionWeather.text  =  info.weather.first?.description
        cityText.text = info.name
//                iconWeather.image = UIImage(data: info.weather[0].icon)
        
    }
    
    private func populateCities() {
        cities.append("Paris")
        cities.append("New York")
    }
}

