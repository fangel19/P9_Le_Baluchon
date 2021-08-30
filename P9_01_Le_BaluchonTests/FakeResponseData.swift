//
//  FakeResponseData.swift
//  P9_01_Le_BaluchonTests
//
//  Created by angelique fourny on 25/08/2021.
//

import Foundation

class FakeResponseData {
    
    // MARK: - Response
    
    let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    // MARK: - Data
    
    var cashCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Cash", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    let IncorrectData = "erreur" .data(using: .utf8)!
    
    // MARK: - Error
     
     class TestError: Error {}
     
     let error = TestError()
}
