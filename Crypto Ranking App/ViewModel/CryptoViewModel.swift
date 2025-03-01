//
//  CryptoViewModel.swift
//  Crypto Ranking App
//
//  Created by Martha Nashipae on 21/02/2025.
//

import Foundation
class CryptoViewModel: ObservableObject {
    @Published var coins: [Coin] = [] // All coins
    @Published var favorites: [Coin] = [] // Favorites list

    func toggleFavorite(_ coin: Coin) {
        if let index = favorites.firstIndex(where: { $0.uuid == coin.uuid }) {
            favorites.remove(at: index) // Remove from favorites
        } else {
            favorites.append(coin) // Add to favorites
        }
        
        self.saveFavorites(coin: coin)
    }

    func isFavorite(_ coin: Coin) -> Bool {
        return favorites.contains(where: { $0.uuid == coin.uuid })
    }
    
    func saveFavorites(coin:Coin) {
        if let encoded = try? JSONEncoder().encode(coin) {
            UserDefaults.standard.set(encoded, forKey: "favoriteCoins")
        }
    }
    
    func loadFavorites() {
       
        if let savedData = UserDefaults.standard.data(forKey: "favoriteCoins"),
          
           let decodedCoins = try? JSONDecoder().decode([Coin].self, from: savedData) {
           
            favorites = decodedCoins
            
        }
    }
}
