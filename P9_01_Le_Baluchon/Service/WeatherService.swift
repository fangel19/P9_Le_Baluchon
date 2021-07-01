//
//  weather.swift
//  P9_01_Le_Baluchon
//
//  Created by angelique fourny on 14/06/2021.
//

import Foundation

class WeatherService {
    
    // MARK: - Singleton
    
    static let shared = WeatherService()
    
    enum APIError: Error {
        case server
        case decoding
    }
    
    func getWeather(city: String, completion: @escaping (Result<WeatherInfo, APIError>) -> Void) {
        
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=df50781f0d5dda3bc246e09ed6adaa23&units=metric&lang=fr"
        guard let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let urlWeather = URL(string: url)
    
        guard let url = urlWeather else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error ==  nil else { completion(.failure(.server))
                print("erreur")
                return
            }
            do {
                guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.failure(.server))
                    print("pas de data")
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode(WeatherInfo.self, from: data) else {
                    completion(.failure(.decoding))
                    return
                }
                completion(.success(responseJSON))
            }
        }
        task.resume()
    }
}


