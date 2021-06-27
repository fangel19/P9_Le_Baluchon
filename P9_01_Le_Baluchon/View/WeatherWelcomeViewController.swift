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
    
    @IBOutlet weak var tempWeather2: UILabel!
    @IBOutlet weak var iconWeather2: UIImageView!
    @IBOutlet weak var descriptionWeather2: UILabel!
    @IBOutlet weak var city2: UIPickerView!
    
    //    private var cities = [String]()
    private var cities: [String] = []
//    let weatherService = WeatherInfo()
    
    
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
                
                print("=> success")
            case .failure(let error):
                print(error.localizedDescription)
//                self.alertMessage(with: "error")
            }
        }
    }
    
    private func viewWeather(info: WeatherInfo) {
        tempWeather.text = String(info.main.temp)
        descriptionWeather.text  =  info.weather.first?.description
        cityText.text = info.name
        tempWeather2.text = String(info.main.temp)
        descriptionWeather2.text = info.weather.first?.description
        city2.selectedRow(inComponent: 0)
        //                iconWeather.image = UIImage(data: info.weather[0].icon)
        
    }
    
    private func populateCities() {
        cities.append("Paris")
        cities.append("New York")
    }
}

extension WeatherWelcomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == city2 {
            return cities.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == city2 {
            return cities[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewWeather =
    }
}
