//
//  UserCash.swift
//  P9_01_Le_Baluchon
//
//  Created by angelique fourny on 25/06/2021.
//

import Foundation

struct CashInfo: Decodable {
    
    let rates: [String: Double]
}

extension CashInfo {
    private func convertFromEuro(value: Double, rates: Double) -> Double {
        return value * rates
    }
    private func convertToEuro(value: Double, rates: Double) -> Double {
        return value / rates
    }
    func convert(value: Double, from: String, to: String) -> Double {
        if from == "EUR" {
            
            let rate = Double((rates[to] ?? 0.0))
            let convertValue = convertFromEuro(value: value, rates: rate)
            return convertValue
            
        } else {
            
            var rate = Double((rates[from] ?? 0.0))
            let value = convertToEuro(value: value, rates: rate)
            
            rate = Double((rates[to] ?? 0.0))
            let convertValue = convertFromEuro(value: value, rates: rate)
            return convertValue
        }
    }
}

