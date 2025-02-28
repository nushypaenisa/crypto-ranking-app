//
//  APIManagerTests.swift
//  APIManagerTests
//
//  Created by Martha Nashipae on 01/03/2025.
//

import XCTest
@testable import Crypto_Ranking_App

class APIManagerTests: XCTestCase {

    func testFetchCoins() {
            let expectation = self.expectation(description: "Fetch Coins")
            
            APIManager.shared.fetchCoins(page: 0, orderBy: "name") { result in
                switch result {
                case .success(let coins):
                    XCTAssertFalse(coins.isEmpty, "Coins list should not be empty")
                case .failure(let error):
                    XCTFail("API call failed: \(error.localizedDescription)")
                }
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 5.0)
        }
    
    func testCoinDecoding() {
        let json = """
        {
            "data": {
                "coins": [{
                    "uuid": "Qwsogvtv82FCd",
                    "name": "Bitcoin",
                    "iconUrl": "https://cdn.coinranking.com/Sy33Krudb/btc.svg",
                    "price": "9370.99",
                    "change": "-0.52"
                }]
            }
        }
        """.data(using: .utf8)!
        
        do {
            let decodedResponse = try JSONDecoder().decode(CoinResponse.self, from: json)
            XCTAssertEqual(decodedResponse.data.coins.first?.name, "Bitcoin")
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
    
    
}
