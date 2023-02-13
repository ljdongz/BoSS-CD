//
//  PlaceNetManager.swift
//  iOS
//
//  Created by 이정동 on 2023/01/26.
//

import Foundation

// 여행지 데이터 네트워킹
class PlaceNetManager {
    
    static let shared = PlaceNetManager()
    private init() {}
    
    // 여행지 데이터 불러오기
    /// - parameter uid : User ID
    /// - parameter completion : Place 데이터를 이용한 화면 작업
    func read(uid: Int, startDate: String?, endDate: String?, completion: @escaping ([Place])->()) {

        var queryString = ""
        if let start = startDate, let end = endDate {
            queryString = "?start=\(start)&end=\(end)"
            //queryString = queryString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! // 한글 인코딩
            print(start)
            print(end)
        }
        
        guard let url = URL(string: "\(Bundle.main.REST_API_URL)/api/places/read/\(uid)\(queryString)") else { return }
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, res, err in
            if err != nil {
                print("Place Net Error")
                return
            }
            
            guard let response = res as? HTTPURLResponse, (200 ..< 299) ~=
                    response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            if let safeData = data {
                do {
                    let decodedData = try JSONDecoder().decode(PlaceData.self, from: safeData)
                    dump(decodedData)
                    completion(decodedData.places)
                } catch {
                    print("Decode Error")
                }
            }
        }.resume()
    }
    
    func read(sid: Int, completion: @escaping ([Place])->()) {
        
        guard let url = URL(string: "\(Bundle.main.REST_API_URL)/api/place/read/\(sid)") else { return }
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, res, err in
            if err != nil {
                print("Place Net Error")
                return
            }
            
            guard let response = res as? HTTPURLResponse, (200 ..< 299) ~=
                    response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            if let safeData = data {
                do {
                    let decodedData = try JSONDecoder().decode(PlaceData.self, from: safeData)
                    dump(decodedData)
                    completion(decodedData.places)
                } catch {
                    print("Decode Error")
                }
            }
        }.resume()
    }
}
