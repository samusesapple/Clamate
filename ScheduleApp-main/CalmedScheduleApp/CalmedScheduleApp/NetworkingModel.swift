//
//  Dust.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/21.
//

import Foundation

struct Dust: Codable {
    let status: String?
    let data: DataClass?
}

struct DataClass: Codable {
    let aqi: Int?
}

struct WeatherData: Codable {
    let weather: [Weather]
    let main: TempMain
}

struct TempMain: Codable {
    let temp: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
    }
}

struct Weather: Codable {
    let description: String
}


