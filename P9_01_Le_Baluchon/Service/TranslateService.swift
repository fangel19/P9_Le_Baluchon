//
//  TranslateService.swift
//  P9_01_Le_Baluchon
//
//  Created by angelique fourny on 25/06/2021.
//

import Foundation

class TranslateService {
    
    // MARK: - Singleton
    
    static let shared = TranslateService()
    
    // MARK: - API Key

    private var apiKey = "AIzaSyBjz9BBKSKzzKSpFgxumEXOxIjWzFn1XBc"
    
    // MARK: - Enum API

    enum APIError: Error {
        
        case server
        case decoding
    }
    
    // MARK: - Call API

    func postTranslate(language: String, completion: @escaping (Result<Translate, APIError>) -> Void) {
        
        guard let urlTranslate = URL(string: "https://translation.googleapis.com/language/translate/v2?") else { return }
        
        var request = URLRequest(url: urlTranslate)
        request.httpMethod = "POST"
        
        let query = language
        
        let body = "q=\(query)" + "&source=fr" + "&target=en" + "&format=text" + "&key=\(apiKey)"
        
        request.httpBody = body.data(using: .utf8)
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else { completion(.failure(.server))
                print("erreur")
                return
            }
            do {
                
                guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.failure(.server))
                    print("pas de data")
                    return
                }
                
                guard let responseJson = try?
                        JSONDecoder().decode(Translate.self, from: data) else {
                    completion(.failure(.decoding))
                    return
                }
                
                completion(.success(responseJson))
            }
        }
        
        task.resume()
    }
}
