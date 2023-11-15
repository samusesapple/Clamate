//
//  File.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/21.
//

import Foundation

//MARK: - NetworkError

enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}


final class NetworkManager {

    let tempServiceKey = "0148f2d4545ea1be79ccf51e2339c35c"
    let dustServiceKey = "7027a677183704666f97ce3f15f7134811d487f2"
    
    static let shared = NetworkManager()
    private init() {}
    
    typealias NetworkCompletion = (Result<Any?, NetworkError>) -> Void
    
    func fetchTemp(city: String, completion: @escaping NetworkCompletion) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=\(tempServiceKey)&lang=kr"
        print(urlString)
        tempPerformRequest(with: urlString) { result in
            completion(result)
        }
    }
    
    private func tempPerformRequest(with urlString: String, completion: @escaping NetworkCompletion) {
        print(#function)
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                completion(.failure(.networkingError))
                return
            }
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            // 데이터 분석하기
            if let tempData = self.parseTempJSON(safeData) {
                completion(.success(tempData))
            } else {
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
    
    private func parseTempJSON(_ tempData: Data) -> Double? {
        // 성공
        do {
            let decodedTempData = try JSONDecoder().decode(WeatherData.self, from: tempData)
            return decodedTempData.main.temp
        } catch {
            return nil
        }
    }
    
    func fetchDust(city: String, completion: @escaping NetworkCompletion) {
        let urlString = "https://api.waqi.info/feed/\(city)/?token=\(dustServiceKey)"
        dustPerformRequest(with: urlString) { result in
            completion(result)
        }
    }
    
    private func dustPerformRequest(with urlString: String, completion: @escaping NetworkCompletion) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                completion(.failure(.networkingError))
                return
            }
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            // 데이터 분석하기
            if let dustData = self.parseDustJSON(safeData) {
                completion(.success(dustData))
            } else {
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
    
    // 받아본 데이터 분석하는 함수 (동기적 실행)
    private func parseDustJSON(_ dustData: Data) -> Int? {
        // 성공
        do {
            print(String(data: dustData, encoding:.utf8)!)
            let decodedDustData = try JSONDecoder().decode(Dust.self, from: dustData)
            let dustData = decodedDustData
            return dustData.data?.aqi
        // 실패
        } catch {
            return nil
        }
    }
}
