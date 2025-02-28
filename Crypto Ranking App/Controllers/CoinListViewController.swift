//
//  CoinListViewController.swift
//  Crypto Ranking App
//
//  Created by Martha Nashipae on 21/02/2025.
//

import UIKit
import SwiftUI
import DGCharts

// MARK: - Coin List View Controller (UIKit)
class CoinListViewController: UITableViewController {
    
 
    var coins: [Coin] = []
    var favoriteCoins: [Coin] = []
    private var currentPage = 0
    private let searchButton = UIButton()
    private let filterButton = UIButton()
    private var isLoading = false
    var filteredCoins: [Coin] = []
    private var selectedOrderBy = "name"


    override func viewDidLoad() {
        super.viewDidLoad()
     

        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: filterButton),
            UIBarButtonItem(customView: searchButton)
        ]
        tableView.register(CryptoViewCell.self, forCellReuseIdentifier: "cryptoViewCell")
        tableView.rowHeight = 60
        setupTableHeader()
        fetchCoins()


    }
    
//    func setupTableHeader() {
//         let segmentControl = UISegmentedControl(items: ["name", "Price", "24h Volume"])
//         segmentControl.selectedSegmentIndex = 0
//         segmentControl.addTarget(self, action: #selector(filterChanged(_:)), for: .valueChanged)
//
//         let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
//         segmentControl.frame = CGRect(x: 10, y: 10, width: view.frame.width - 20, height: 30)
//         headerView.addSubview(segmentControl)
//
//         tableView.tableHeaderView = headerView
//     }
    
    func setupTableHeader() {
        let segmentControl = UISegmentedControl(items: ["name", "Price", "24h Volume"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(filterChanged(_:)), for: .valueChanged)
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(segmentControl)

        NSLayoutConstraint.activate([
            segmentControl.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            segmentControl.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            segmentControl.widthAnchor.constraint(equalTo: headerView.widthAnchor, constant: -20)
        ])
        
        tableView.tableHeaderView = headerView
    }

     @objc func filterChanged(_ sender: UISegmentedControl) {
         switch sender.selectedSegmentIndex {
         case 0:
             selectedOrderBy = "name"
         case 1:
             selectedOrderBy = "price"
         case 2:
             selectedOrderBy = "24hVolume"
         default:
             selectedOrderBy = "marketCap"
         }
         
         currentPage = 0
         coins.removeAll()
         fetchCoins()
     }
    func fetchCoins() {
            guard !isLoading else { return } // Prevent duplicate requests
            isLoading = true

            APIManager.shared.fetchCoins(page: currentPage, orderBy: selectedOrderBy) { result in
                DispatchQueue.main.async {
                    self.isLoading = false
                    switch result {
                    case .success(let newCoins):
                        self.coins.append(contentsOf: newCoins)
                        self.currentPage += 1
                        self.tableView.reloadData()
                    case .failure(let error):
                        print("Error fetching coins: \(error.localizedDescription)")
                    }
                }
            }
        }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if coins.count == 0 {
            
            tableView.setEmptyViewItem(title: "You don't have any Cryptos.", message: "Your Cryptos will be in here.")
        }
        else {
            tableView.restoreItem()
        }
        return coins.count
       
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Reuse or create a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cryptoViewCell",
                              for: indexPath) as! CryptoViewCell

        let coin = coins[indexPath.row]

        cell.configure(with: coin)


        return cell

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = coins[indexPath.row]
        let swiftUIView = CoinDetailView(crypto: coin)
        let hostingController = UIHostingController(rootView: swiftUIView)
        navigationController?.pushViewController(hostingController, animated: true)
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let coin = coins[indexPath.row]

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

            completionHandler(true)
        }

        favoriteAction.backgroundColor = actionColor
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Load more data when reaching the last 5 rows
        if indexPath.row == coins.count - 5 {
            fetchCoins()
        }
    }

    func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favoriteCoins) {
            UserDefaults.standard.set(encoded, forKey: "favoriteCoins")
        }
    }

    func loadFavorites() {
        print("favoriteCoins 1")
        if let savedData = UserDefaults.standard.data(forKey: "favoriteCoins"),
          
           let decodedCoins = try? JSONDecoder().decode([Coin].self, from: savedData) {
            print("favoriteCoins 2")
            print(decodedCoins)
            favoriteCoins = decodedCoins
            
            print("favoriteCoins")
            print(favoriteCoins)
        }
    }
}

extension UITableView {
    func setEmptyViewItem(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
       
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
       
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        
        titleLabel.text = title
        
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
        }
    
    func restoreItem() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
