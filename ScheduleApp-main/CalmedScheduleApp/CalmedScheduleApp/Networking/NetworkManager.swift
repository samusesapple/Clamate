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
    
    let serviceKey = "XVxOMSZ70W298ghokOf%2FHLbcGN1dn%2BTIUo7VXeKn7RU5ulkaYWdxquve8NIbwvBLcb%2BT6096HColuycWG%2F20fg%3D%3D"
    let searchDate = "2023-03-21"
    
    static let shared = NetworkManager()
    private init() {}
    
    typealias NetworkCompletion = (Result<Item?, NetworkError>) -> Void
    
//    let url = "https://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMinuDustFrcstDspth?serviceKey=\(serviceKey)&returnType=JSON&numOfRows=1&searchDate=\(searchDate)"
//

    func fetchDust(date: String, completion: @escaping NetworkCompletion) {
        let urlString = "https://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMinuDustFrcstDspth?serviceKey=\(serviceKey)&returnType=JSON&numOfRows=1&searchDate=\(date)"
        print(urlString)
        performRequest(with: urlString) { result in
            completion(result)
            print("\(result)")
        }
    }
    
    
    private func performRequest(with urlString: String, completion: @escaping NetworkCompletion) {
        //print(#function)
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                completion(.failure(.networkingError))
                print("networkingError")
                return
            }
            guard let safeData = data else {
                completion(.failure(.dataError))
                print("Data Error")
                return
            }
            print("Data ok")
            
            // 데이터 분석하기
            if let dustData = self.parseJSON(safeData) {
                print("Parse 실행")
                completion(.success(dustData))
                print("Parsing ok")
            } else {
                print("Parse 실패")
                completion(.failure(.parseError))
                print("ParsingFailed")
            }
        }
        task.resume()
    }
    
    // 받아본 데이터 분석하는 함수 (동기적 실행)
    private func parseJSON(_ dustData: Data) -> Item? {
        print(#function)
        // 성공
        do {
            let decodedDustData = try JSONDecoder().decode(Item.self, from: dustData)
            return decodedDustData
        // 실패
        } catch {
            print(error.localizedDescription)
            print("localizedDescription error")
            return nil
        }
    }
}
