//
//  WeatherDataManager.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/17.
//

import Foundation

final class DustManager {
    
    static let shared = DustManager()
    
    private var todayDateString: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        let todayDateString = myFormatter.string(from: Date())
        return todayDateString
    }
    

    private init() {}
    
    private let networkManager = NetworkManager.shared
    
    var dustResult: Item?
    
    func getTodayDust(completion: @escaping () -> Void) {
        networkManager.fetchDust(date: todayDateString!) { result in
            switch result {
            case .success(let result):
                self.dustResult = result
                completion()
            case .failure(let error):
                print(error.localizedDescription)
                completion()
            }
        }
    }
}
