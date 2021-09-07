//
//  FakeResponseData.swift
//  P9_01_Le_BaluchonTests
//
//  Created by angelique fourny on 25/08/2021.
//

import Foundation

class FakeResponseData {
    
    // MARK: - Response
    
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    // MARK: - Data
    
    static var cashCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Cash", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var translateCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let IncorrectData = "erreur" .data(using: .utf8)!
    
    // MARK: - Error
         
     class ConversionError: Error {}
     
     static let conversionError = ConversionError()
}
