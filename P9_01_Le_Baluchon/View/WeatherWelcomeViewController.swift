//
//  WeatherWelcomeViewController.swift
//  P9_01_Le_Baluchon
//
//  Created by angelique fourny on 11/06/2021.
//

import UIKit

class WeatherWelcomeViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Outlets
    
    @IBOutlet weak var tempWeather: UILabel!
    @IBOutlet weak var iconWeather: UIImageView!
    @IBOutlet weak var descriptionWeather: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempWeather2: UILabel!
    @IBOutlet weak var iconWeather2: UIImageView!
    @IBOutlet weak var descriptionWeather2: UILabel!
    @IBOutlet weak var citiesPickerView: UIPickerView!
    @IBOutlet weak var validateButton: UIButton!
    
    // MARK: - Properties
    
    private var cities: [String] = ["Paris", "New York", "Londres", "Madrid", "Tokyo"]
    
    private var spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        citiesPickerView.delegate = self
        citiesPickerView.dataSource = self
        citiesPickerView.selectRow(0, inComponent: 0, animated: false)
        updateWeatherOne()
        updateWeatherTwo()
        setUpSpinner()
    }
    
    // Loading switch validation button
    private func setUpSpinner() {
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: validateButton.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: validateButton.centerYAnchor).isActive = true
    }
    
    private func loadingLayout(isActive: Bool) {
        
        if isActive {
            
            spinner.startAnimating()
            
        } else {
            
            spinner.stopAnimating()
        }
    }
    
    private func loadingButton(show: Bool) {
        
        self.validateButton.isHidden = show
    }
    
    //to display the weather forecast according to the selected country
    private func updateWeatherOne() {
        
        WeatherService.shared.getWeather(city: cities[1]) { [weak self] result in
            switch result {
            
            case .success(let weather):
                DispatchQueue.main.async {
                    
                    self?.tempWeather.text =  String(weather.main.temp.tempInt)
                    self?.descriptionWeather.text  =  weather.weather.first?.description
                    self?.cityLabel.text = weather.name
                    
                    if let icon = weather.weather.first?.icon {
                        
                        self?.iconWeather.downloaded(from: "https://openweathermap.org/img/wn/\(icon)@2x.png")
                        print("ICI =>", weather.name)
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    
                    self?.alertMessage(title: "Erreur", message: "impossible d'afficher la selection, verifier votre connexion")
                    print("error")
                }
            }
        }
    }
    
    private func updateWeatherTwo() {
        
        loadingLayout(isActive: true)
        loadingButton(show: true)
        
        WeatherService.shared.getWeather(city: cities[citiesPickerView.selectedRow(inComponent: 0)]) { [weak self] result in
            switch result {
            
            case .success(let weather):
                DispatchQueue.main.async {
                    
                    self?.loadingLayout(isActive: false)
                    self?.loadingButton(show: false)
                    self?.tempWeather2.text = String(weather.main.temp.tempInt)
                    self?.descriptionWeather2.text = weather.weather.first?.description
                    
                    if let icon = weather.weather.first?.icon {
                        
                        self?.iconWeather2.downloaded(from: "https://openweathermap.org/img/wn/\(icon)@2x.png")
                        print("=> success")
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    
                    self?.alertMessage(title: "Erreur", message: "impossible d'afficher la selection, verifier votre connexion")
                    print("error")
                }
            }
        }
    }
    
    //    MARK: - Alert message
    
    private func alertMessage(title: String, message: String) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    //    MARK: - Action button validate
    
    @IBAction func validation(_ sender: Any) {
        
        updateWeatherTwo()
    }
}

//MARK: - Delegate

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
    }
}

