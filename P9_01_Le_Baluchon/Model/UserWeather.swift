//
//  WeatherType.swift
//  P9_01_Le_Baluchon
//
//  Created by angelique fourny on 16/06/2021.
//

import Foundation


struct WeatherInfo: Decodable {
    let weather: [WeatherElement]
    let main: Main
    let name: String
}
struct WeatherElement: Decodable {
    let description: String
    let icon: String
    
}

struct Main: Decodable {
    let temp: Float
}

enum CodingKeys: String, CodingKey {
    case name = "name"
    case description = "description"
    case icon = "icon"
    case temp
    
}

