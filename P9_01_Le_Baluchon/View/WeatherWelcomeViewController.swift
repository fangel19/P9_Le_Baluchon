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
    
    private var usersArray: [WeatherInfo]? {
        didSet {
            DispatchQueue.main.async {
                self.cityText.reloadInputViews()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toto(str: "angelique")
        updateWeather()
        
    }
    @IBAction func validation(_ sender: Any) {
        updateWeather()
    }
    
    private func updateWeather() {
        WeatherService.shared.getWeather(city: cityText.text ?? "") { result in
            switch result {
            case .success(let weather):
                self.usersArray = weather
                //                self.viewWeather(info: weather[0])
                print("success")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    //    WeatherInfo.init(weather: [WeatherElement.init(description: "nuageux", Icon: "04d")], main: Main.init(temp: 24.29), name: "Paris")
    //    //        viewWeather()
    
    func toto(str: String) {
        print("Bonjour (\(str) !")
    }
    
    
    
    private func viewWeather(info: WeatherInfo) {
        tempWeather.text = String(info.main.temp)
        descriptionWeather.text  =  info.weather.description
        cityText.text = info.name
        //        iconWeather.image = UIImage(data: info.weather[0].icon)
        
    }
//    private func view(info: CodingKeys) {
//        descriptionWeather.text = info.description
//        iconWeather.image = UIImage()
//    }
    
}

