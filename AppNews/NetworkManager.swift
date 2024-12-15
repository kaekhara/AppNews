//
//  NetworkManager.swift
//  AppNews
//
//  Created by Beibarys Yermakhan on 15.12.2024.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private let apiUrl = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=8f55a6afde814347b7fd9ad1bd37e3ca"
    
    private init() {}
    
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        AF.request(apiUrl).validate().responseDecodable(of: NewsResponse.self) { response in
            switch response.result {
            case .success(let newsResponse):
                completion(.success(newsResponse.articles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
