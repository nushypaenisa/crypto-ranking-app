//
//  APIManager.swift
//  Crypto Ranking App
//
//  Created by Martha Nashipae on 21/02/2025.
//

import Foundation


// MARK: - API Manager
class APIManager {
    static let shared = APIManager()
    private let baseURL = "https://api.coinranking.com/v2/coins"
    private let apiKey = "coinrankingfeeece4dfc4e97323ea22ba22747c7190de453dd00197321"  // Replace with actual API Key
   
    
    func fetchCoins(page: Int, orderBy: String, completion: @escaping (Result<[Coin], Error>) -> Void) {
        let urlString = "\(baseURL)?limit=20&offset=\(page * 20)&orderBy=\(orderBy)"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "x-access-token")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            
            do {
                let decodedResponse = try JSONDecoder().decode(CoinResponse.self, from: data)
                completion(.success(decodedResponse.data.coins))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
//    func fetchCoins(page: Int, completion: @escaping (Result<[Coin], Error>) -> Void) {
//        let urlString = "\(baseURL)?limit=20&offset=\(page * 20)"
//        guard let url = URL(string: urlString) else { return }
//
//        var request = URLRequest(url: url)
//        request.setValue(apiKey, forHTTPHeaderField: "x-access-token")
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//
//
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            guard let data = data else { return }
//
//
//            do {
//
//                let decodedResponse = try JSONDecoder().decode(CoinResponse.self, from: data)
//
//                completion(.success(decodedResponse.data.coins))
//            } catch {
//
//                completion(.failure(error))
//            }
//        }.resume()
//    }
}
