//
//  FavoriteCoinViewController.swift
//  Crypto Ranking App
//
//  Created by Martha Nashipae on 22/02/2025.
//

import Foundation

import UIKit
import SwiftUI
import DGCharts

// MARK: - Coin List View Controller (UIKit)
class FavoriteCoinViewController: UITableViewController {
  
    var favoriteCoins: [Coin] = []
    private var currentPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite Coins"
        tableView.register(CryptoViewCell.self, forCellReuseIdentifier: "favCryptoViewCell")
        tableView.rowHeight = 60
        loadFavorites()
        
        
    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favoriteCoins.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Reuse or create a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCryptoViewCell",
                              for: indexPath) as! CryptoViewCell

        let coin = favoriteCoins[indexPath.row]

        cell.configure(with: coin)
        
       
        return cell
       
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = favoriteCoins[indexPath.row]
        let swiftUIView = CoinDetailView(crypto: coin)
        let hostingController = UIHostingController(rootView: swiftUIView)
        navigationController?.pushViewController(hostingController, animated: true)
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let coin = favoriteCoins[indexPath.row]

        // Check if the coin is already in favorites
        let isFavorite = favoriteCoins.contains(where: { $0.uuid == coin.uuid })

        let actionTitle = isFavorite ? "Unfavorite" : "Favorite"
        let actionColor = isFavorite ? UIColor.red : UIColor.green

        let favoriteAction = UIContextualAction(style: .normal, title: actionTitle) { [weak self] _, _, completionHandler in
            guard let self = self else { return }

            if isFavorite {
                // Remove from favorites
                self.favoriteCoins.removeAll { $0.uuid == coin.uuid }
            } else {
                // Add to favorites
                self.favoriteCoins.append(coin)
            }

            // Save favorites to UserDefaults (optional)
            self.saveFavorites()
            self.tableView.reloadData()
            completionHandler(true)
        }

        favoriteAction.backgroundColor = actionColor
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }

    func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favoriteCoins) {
            UserDefaults.standard.set(encoded, forKey: "favoriteCoins")
        }
    }

    func loadFavorites() {
       
        if let savedData = UserDefaults.standard.data(forKey: "favoriteCoins"),
          
           let decodedCoins = try? JSONDecoder().decode([Coin].self, from: savedData) {
           
            favoriteCoins = decodedCoins
            
        }
    }
}
