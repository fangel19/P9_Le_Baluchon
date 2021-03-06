//
//  UserTranslate.swift
//  P9_01_Le_Baluchon
//
//  Created by angelique fourny on 25/06/2021.
//

import Foundation

// MARK: - Translate

struct Translate: Decodable {
    
    let data: DataClass
}

// MARK: - DataClass

struct DataClass: Decodable {
    
    let translations: [Translation]
}

// MARK: - Translation

struct Translation: Decodable {
    
    let translatedText: String
}
