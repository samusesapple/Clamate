//
//  WeatherDataManager.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/17.
//

import Foundation

// MARK: - WeatherDataError
enum WeatherDataError: Error {
    case failToGetTemperatureData(String)
    case failToGetDustData(String)
}

// MARK: - WeatherDataManager

final class WeatherDataManager {
    
    static let shared = WeatherDataManager()
    private let userDataManager = CoreDataManager.shared
    
    private init() {}
    
    private let networkManager = NetworkManager.shared
    
    var tempResult: Double?
    var dustResult: Int?
    
    func getTodayTemp(completion: @escaping () -> Void) {
        var userCity = userDataManager.getUserInfoFromCoreData()?.userCity ?? "Seoul"
        
        networkManager.fetchTemp(city: userCity) { result in
            switch result {
            case .success(let result):
                self.tempResult = result as? Double
                completion()
            case .failure(let error):
                print(WeatherDataError.failToGetTemperatureData(error.localizedDescription))
            }
        }
    }
    
    func getTodayDust(completion: @escaping () -> Void) {
        var userCity = userDataManager.getUserInfoFromCoreData()?.userCity ?? "Seoul"
        
        networkManager.fetchDust(city: userCity) { result in
            switch result {
            case .success(let result):
                self.dustResult = result as? Int
                completion()
            case .failure(let error):
                print(WeatherDataError.failToGetDustData(error.localizedDescription))
            }
        }
    }
}
