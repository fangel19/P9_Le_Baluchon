//
//  CashService.swift
//  P9_01_Le_Baluchon
//
//  Created by angelique fourny on 25/06/2021.
//

import Foundation

class CashService {
    
    // MARK: - Singleton
    
    static let shared = CashService()
    
    enum APIError: Error {
        case server
        case decoding
    }
    
    func getCash(completion: @escaping (Result<CashInfo, APIError>) -> Void) {
        
        let urlCash = URL(string: "http://data.fixer.io/latest?access_key=69821d275fa932b77bb0f107de2eb4eb")
        
        guard let url = urlCash else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
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
                        JSONDecoder().decode(CashInfo.self, from: data) else {
                    completion(.failure(.decoding))
                    return
                }
                completion(.success(responseJson))
            }
        }
        task.resume()
    }
}

