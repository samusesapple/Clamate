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
    
    // MARK: - Temp
    func getTodayTemp(completion: @escaping () -> Void) {
        if userDataManager.getUserInfoFromCoreData().count > 0 {
            let userCity = userDataManager.getUserInfoFromCoreData()[0].userCity
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
        } else {
            print("날씨 - 유저 도시 정보 없음")
        }
    }
    
    // MARK: - Dust
    func getTodayDust(completion: @escaping () -> Void) {
        if userDataManager.getUserInfoFromCoreData().count > 0 {
            let userCity = userDataManager.getUserInfoFromCoreData()[0].userCity
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
        } else {
            print("미세먼지 - 유저 도시 정보 없음")
        }
    }
    

    
}
