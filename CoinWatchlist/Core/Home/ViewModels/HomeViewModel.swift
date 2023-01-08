//
//  HomeViewModel.swift
//  CoinWatchlist
//
//  Created by Arif Siregar on 06/01/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var coins = [Coin]()
    @Published var topMovingCoins = [Coin]()
    @Published var isLoadingData = true
    
    init() {
        fetchCoinData()
    }
    
    func fetchCoinData() {
        self.isLoadingData = true
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("DEBUG: Error \(error.localizedDescription)")
                self.isLoadingData = false
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("DEBUG: Response code \(response.statusCode)")
            }
            
            guard let data = data else { return }
//            let dataAsString = String(data: data, encoding: .utf8)
//            print("DEBUG: Data \(String(describing: dataAsString))")
            
            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                DispatchQueue.main.async {
                    self.coins = coins
                    self.configureTopMovingCoins()
                    self.isLoadingData = false
                }
//                print("DEBUG: Coins \(String(describing: coins.first))")
            } catch let error {
                print("DEBUG: Failed to decode with error: \(error)")
                self.isLoadingData = false
            }
            
        }.resume()
    }
    
    func configureTopMovingCoins() {
        let topMovers = coins.sorted(by: { $0.priceChangePercentage24H > $1.priceChangePercentage24H })
        self.topMovingCoins = Array(topMovers.prefix(5))
    }
}
