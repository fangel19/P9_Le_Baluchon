//
//  WeatherType.swift
//  P9_01_Le_Baluchon
//
//  Created by angelique fourny on 16/06/2021.
//

import Foundation

// MARK: - WeatherInfo

struct WeatherInfo: Decodable {
    
    let weather: [WeatherElement]
    let main: Main
    let name: String
}

// MARK: - WeatherElement

struct WeatherElement: Decodable {
    
    let description: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        
        case description = "description"
        case icon = "icon"
    }
}

// MARK: - Main

struct Main: Decodable {
    
    let temp: Double
    
    enum CodingKeys: String, CodingKey {
        
        case temp
    }
}
