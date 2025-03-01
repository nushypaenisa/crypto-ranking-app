//
//  ContentView.swift
//  Crypto Ranking App
//
//  Created by Martha Nashipae on 20/02/2025.
//




import UIKit
import SwiftUI
import DGCharts


struct ContentView: View {
    @StateObject private var viewModel = CryptoViewModel()

    var body: some View {
        NavigationView {
            
            TabView {
                CoinListViewWrapper(viewModel: viewModel)

                    .navigationTitle("Crypto Ranking")
                    .navigationBarHidden(false)
                    .edgesIgnoringSafeArea(.bottom).tabItem { Image(systemName: "house.fill"); Text("Coins").font(.system(size: 30, weight: .bold, design: .rounded))}
                
                FavCoinListViewWrapper(viewModel: viewModel)

                    .navigationTitle("Crypto Ranking")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .edgesIgnoringSafeArea(.bottom).tabItem { Image(systemName: "heart.fill"); Text("Favorite")}
            }
          
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CoinListViewWrapper: UIViewControllerRepresentable {
    @ObservedObject var viewModel: CryptoViewModel
    func makeUIViewController(context: Context) -> CoinListViewController {
        return CoinListViewController(viewModel: viewModel)
    }

    func updateUIViewController(_ uiViewController: CoinListViewController, context: Context) {
        // No update logic needed for now
    }
    
   
}


struct FavCoinListViewWrapper: UIViewControllerRepresentable {
    @ObservedObject var viewModel: CryptoViewModel
    
    func makeUIViewController(context: Context) -> FavoriteCoinViewController {
        return FavoriteCoinViewController(viewModel: viewModel)
    }

    func updateUIViewController(_ uiViewController: FavoriteCoinViewController, context: Context) {
        // No update logic needed for now
        uiViewController.updateTableView()
    }
}





