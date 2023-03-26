//
//  File.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/21.
//

import Foundation

//MARK: - error

enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

//MARK: - Networking model

final class NetworkManager {
    // MARK: - keys
    let tempServiceKey = "0148f2d4545ea1be79ccf51e2339c35c"
    let dustServiceKey = "7027a677183704666f97ce3f15f7134811d487f2"
    
    static let shared = NetworkManager()
    private init() {}
    
    typealias NetworkCompletion = (Result<Any?, NetworkError>) -> Void
    
    // MARK: - Temp
    func fetchTemp(city: String, completion: @escaping NetworkCompletion) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=\(tempServiceKey)&lang=kr"
        print(urlString)
        tempPerformRequest(with: urlString) { result in
            completion(result)
            print("\(result)")
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
                print("날씨 networkingError")
                return
            }
            guard let safeData = data else {
                completion(.failure(.dataError))
                print("날씨 Data Error")
                return
            }
            print("날씨 Data ok")
            
            // 데이터 분석하기
            if let tempData = self.parseTempJSON(safeData) {
                print("날씨 Parse 실행")
                completion(.success(tempData))
                print("날씨 Parsing ok")
            } else {
                print("날씨 Parse 실패")
                completion(.failure(.parseError))
                print("날씨 ParsingFailed")
            }
        }
        task.resume()
    }
    
    // 받아본 데이터 분석하는 함수
    private func parseTempJSON(_ tempData: Data) -> Double? {
        print(#function)
        // 성공
        do {
            let decodedTempData = try JSONDecoder().decode(WeatherData.self, from: tempData)
            return decodedTempData.main.temp
        // 실패
        } catch {
            print(error.localizedDescription)
            print("localizedDescription error")
            return nil
        }
    }
    
// MARK: - Dust
    func fetchDust(city: String, completion: @escaping NetworkCompletion) {
        let urlString = "https://api.waqi.info/feed/\(city)/?token=\(dustServiceKey)"
        print(urlString)
        dustPerformRequest(with: urlString) { result in
            completion(result)
            print("\(result)")
        }
    }
    
    private func dustPerformRequest(with urlString: String, completion: @escaping NetworkCompletion) {
        print(#function)
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                completion(.failure(.networkingError))
                print("미세먼지 networkingError")
                return
            }
            guard let safeData = data else {
                completion(.failure(.dataError))
                print("미세먼지 Data Error")
                return
            }
            print("미세먼지 Data ok")
            
            // 데이터 분석하기
            if let dustData = self.parseDustJSON(safeData) {
                print("미세먼지 Parse 실행")
                completion(.success(dustData))
                print("미세먼지 Parsing ok")
            } else {
                print("미세먼지 Parse 실패")
                completion(.failure(.parseError))
                print("미세먼지 ParsingFailed")
            }
        }
        task.resume()
    }
    
    // 받아본 데이터 분석하는 함수 (동기적 실행)
    private func parseDustJSON(_ dustData: Data) -> Int? {
        print(#function)
        // 성공
        do {
            print(String(data: dustData, encoding:.utf8)!)
            let decodedDustData = try JSONDecoder().decode(Dust.self, from: dustData)
            let dustData = decodedDustData
            return dustData.data?.aqi
        // 실패
        } catch {
            print(error)
            print("localizedDescription error")
            return nil
        }
    }
}
