//
//  WeatherDataManager.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/17.
//

import Foundation

final class WeatherDataManager {
    
    static let shared = WeatherDataManager()
    private let userDataManager = CoreDataManager.shared
    
    private init() {}
    
    private let networkManager = NetworkManager.shared
    
    var tempResult: Double?
    var dustResult: Int?
    
    func getTodayTemp(completion: @escaping () -> Void) {
        guard let userData = userDataManager.getUserInfoFromCoreData() else {
            return
        }
        let userCity = userData.userCity
        
        networkManager.fetchTemp(city: userCity ?? "Seoul") { result in
            switch result {
            case .success(let result):
                self.tempResult = result as? Double
                completion()
            case .failure(let error):
                print(error.localizedDescription)
                completion()
            }
        }
    }
    
    func getTodayDust(completion: @escaping () -> Void) {
        guard let userData = userDataManager.getUserInfoFromCoreData() else {
            return
        }
        let userCity = userData.userCity
        networkManager.fetchDust(city: userCity ?? "Seoul") { result in
            switch result {
            case .success(let result):
                self.dustResult = result as? Int
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }
}
