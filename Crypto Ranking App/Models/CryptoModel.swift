//
//  CryptoModel.swift
//  Crypto Ranking App
//
//  Created by Martha Nashipae on 21/02/2025.
//

import Foundation

// MARK: - Welcome
struct CoinResponse: Codable {
    let status: String
    let data: CoinData
}

// MARK: - DataClass
struct CoinData: Codable {
    let stats: Stats
    let coins: [Coin]
}

// MARK: - Coin
struct Coin: Codable {
    let uuid, symbol, name, color: String
    let iconURL: String
    let marketCap, price: String
    let listedAt, tier: Int
    let change: String
    let rank: Int
    let sparkline: [String?]
    let lowVolume: Bool
    let coinrankingURL: String
    let the24HVolume, btcPrice: String
    let contractAddresses: [String]

    enum CodingKeys: String, CodingKey {
        case uuid, symbol, name, color
        case iconURL = "iconUrl"
        case marketCap, price, listedAt, tier, change, rank, sparkline, lowVolume
        case coinrankingURL = "coinrankingUrl"
        case the24HVolume = "24hVolume"
        case btcPrice, contractAddresses
    }
}

// MARK: - Stats
struct Stats: Codable {
    let total, totalCoins, totalMarkets, totalExchanges: Int
    let totalMarketCap, total24HVolume: String

    enum CodingKeys: String, CodingKey {
        case total, totalCoins, totalMarkets, totalExchanges, totalMarketCap
        case total24HVolume = "total24hVolume"
    }
}

//
//// MARK: - Models
//struct CoinResponse: Codable {
//    let data: CoinData
//}
//
//struct CoinData: Codable {
//    let coins: [Coin]
//}
//
//struct Coin: Codable {
////    let uuid: String
////    let name: String
////    let symbol: String
////    let iconUrl: String
////    let price: String
////    let change: String
////    let volume24h: String
////
////    enum CodingKeys: String, CodingKey {
////        case uuid, symbol, name, price, iconUrl,change
////         case volume24h = "24hVolume"
////     }
////
////
//    let uuid: String
//    let symbol: String
//    let name: String
//    let color: String?
//    let iconURL: String
//    let marketCap: String
//    let price: String
//    let listedAt: Int
//    let change: String
//    let rank: Int
//    let sparkline: [String]?
//    let lowVolume: Bool
//    let coinrankingURL: String
//    let volume24h: String
//    let btcPrice: String
//    let contractAddresses: [String]?
//
//    enum CodingKeys: String, CodingKey {
//        case uuid, symbol, name, color, rank, sparkline, lowVolume
//        case iconURL = "iconUrl"
//        case marketCap, price, listedAt, change
//        case coinrankingURL = "coinrankingUrl"
//        case volume24h = "24hVolume"
//        case btcPrice, contractAddresses
//    }
//}
//
//
