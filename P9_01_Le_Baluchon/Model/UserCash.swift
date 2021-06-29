//
//  UserCash.swift
//  P9_01_Le_Baluchon
//
//  Created by angelique fourny on 25/06/2021.
//

import Foundation

struct CashInfo: Codable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: [String: Double]
}
//
//enum CodingKeysCash: String, CodingKey {
//    case success
//    case timestamp
//    case base = "base"
//}
