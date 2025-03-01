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

    var viewModel: CryptoViewModel // Shared ViewModel

     init(viewModel: CryptoViewModel) {
         self.viewModel = viewModel
         super.init(nibName: nil, bundle: nil)
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite Coins"
        tableView.register(CryptoViewCell.self, forCellReuseIdentifier: "favCryptoViewCell")
        tableView.rowHeight = 60
        viewModel.loadFavorites()
        tableView.frame = view.bounds

                // Observe SwiftUI changes
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableView), name: NSNotification.Name("FavoritesUpdated"), object: nil)
        
    }

    @objc func updateTableView() {
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return viewModel.favorites.count
        //return favoriteCoins.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Reuse or create a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCryptoViewCell",
                              for: indexPath) as! CryptoViewCell
        let coin = viewModel.favorites[indexPath.row]
        //let coin = favoriteCoins[indexPath.row]

        cell.configure(with: coin)
        
       
        return cell
       
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = viewModel.favorites[indexPath.row]
        //let coin = favoriteCoins[indexPath.row]
        let swiftUIView = CoinDetailView(crypto: coin)
        let hostingController = UIHostingController(rootView: swiftUIView)
        navigationController?.pushViewController(hostingController, animated: true)
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let coin = viewModel.favorites[indexPath.row]//favoriteCoins[indexPath.row]

        // Check if the coin is already in favorites
        let isFavorite = viewModel.isFavorite(coin)

        let actionTitle = isFavorite ? "Unfavorite" : "Favorite"
        let actionColor = isFavorite ? UIColor.red : UIColor.green

        let favoriteAction = UIContextualAction(style: .normal, title: actionTitle) { [weak self] _, _, completionHandler in
            guard let self = self else { return }
            self.viewModel.toggleFavorite(coin)

            self.tableView.reloadData()
            completionHandler(true)
        }

        favoriteAction.backgroundColor = actionColor
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }

   


}
