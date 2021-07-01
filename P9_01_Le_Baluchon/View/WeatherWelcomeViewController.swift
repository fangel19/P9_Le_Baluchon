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
    
    @IBOutlet weak var cityLabel: UILabel!
    
    
    @IBOutlet weak var tempWeather2: UILabel!
    @IBOutlet weak var iconWeather2: UIImageView!
    @IBOutlet weak var descriptionWeather2: UILabel!
    @IBOutlet weak var citiesPickerView: UIPickerView!
    
    private var cities: [String] = ["Paris", "New York", "Londres", "Berlin"]
    
    
    let dispatchGroup = DispatchGroup()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        citiesPickerView.delegate = self
        citiesPickerView.dataSource = self
        updateWeatherOne()
        updateWeatherTwo()
        
    }
    @IBAction func validation(_ sender: Any) {
        updateWeatherTwo()
        
    }
    
    private func updateWeatherOne() {
        WeatherService.shared.getWeather(city: "Paris") { result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self.tempWeather.text =  String(weather.main.temp)
                    self.descriptionWeather.text  =  weather.weather.first?.description
                    self.cityLabel.text = weather.name
                    self.iconWeather.downloaded(from: "https://openweathermap.org/img/wn/10d@2x.png")
                    print("ICI =>", weather.name)

                }
            case .failure:
                self.alertMessage("Erreur")
                print("error")
            }
        }
    }
    
    private func updateWeatherTwo() {
        WeatherService.shared.getWeather(city: "Londres") { result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self.tempWeather2.text = String(weather.main.temp)
                    self.descriptionWeather2.text = weather.weather.first?.description
                    self.citiesPickerView.selectedRow(inComponent: 0)
                    self.iconWeather2.downloaded(from: "https://openweathermap.org/img/wn/10d@2x.png")
                    print("=> success")

                }
            case .failure:
                print("error")
//                self.alertMessage(with: "error")
            }
        }
    }
    private func alertMessage(_ message: String) {
        let alertVC = UIAlertController(title: "Erreur!", message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
    }
}


extension WeatherWelcomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(cities[row])
//        updateWeatherTwo()
    }
}
