//
//  Dust.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/21.
//

import Foundation

// MARK: - Dust
struct Dust: Codable {
    let list: [DustList]
}

struct DustList: Codable {
    let main: DustMain
}

struct DustMain: Codable {
    let aqi: Int
}



// MARK: - Weather
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

// MARK: - Coord

struct CoordinateElement: Codable {
    let lat, lon: Double

    enum CodingKeys: String, CodingKey {
        case lat, lon
    }
}

typealias Coordinate = [CoordinateElement]
