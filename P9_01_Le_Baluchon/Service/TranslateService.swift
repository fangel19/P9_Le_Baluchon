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
    
    enum APIError: Error {
        case server
        case decoding
    }
    
    func postTranslate(language: String, completion: @escaping (Result<Welcome, APIError>) -> Void) {
        
        let urlTranslate = URL(string: "https://translation.googleapis.com/language/translate/v2?key=AIzaSyBjz9BBKSKzzKSpFgxumEXOxIjWzFn1XBc&q=\(language)&target=EN")
        
        guard let url = urlTranslate else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
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
                        JSONDecoder().decode(Welcome.self, from: data) else {
                    completion(.failure(.decoding))
                    return
                }
                completion(.success(responseJson))
            }
        }
        task.resume()
    }
}
