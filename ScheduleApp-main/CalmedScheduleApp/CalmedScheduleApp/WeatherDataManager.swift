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
    
    private var todayDateString: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        let todayDateString = myFormatter.string(from: Date())
        return todayDateString
    }
    

    private init() {}
    
    private let networkManager = NetworkManager.shared
    
    var tempResult: Double?
    var dustResult: Int?
    var lat: Double?
    var lon: Double?
    
    // MARK: - get Coord
    func getCityCoord(completion: @escaping () -> Void) {
        if userDataManager.getUserInfoFromCoreData().count > 0 {
            let userCity = userDataManager.getUserInfoFromCoreData()[0].userCity
            networkManager.fetchCoord(city: userCity ?? "Seoul") { result in
                switch result {
                case .success(let result):
                   let result = result as? [Double]
                    self.lat = result![0]
                    self.lon = result![1]
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
    func getTodayDust(lat: Double?, lon: Double?, completion: @escaping () -> Void) {
        if userDataManager.getUserInfoFromCoreData().count > 0 {
            networkManager.fetchDust(lat: lat!, lon: lon!) { result in
                switch result {
                case .success(let result):
                    self.dustResult = result as? Int
                    completion()
                case .failure(let error):
                    print(error.localizedDescription)
                    completion()
                }
            }
        } else {
            print("미세먼지 - 유저 도시 정보 없음")
        }
    }
    

    
}
