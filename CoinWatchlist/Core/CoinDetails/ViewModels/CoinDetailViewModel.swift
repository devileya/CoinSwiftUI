//
//  CoinDetailViewModel.swift
//  CoinWatchlist
//
//  Created by Arif Siregar on 07/01/23.
//

import SwiftUI

class CoinDetailViewModel {
    
    private let coin: Coin
    
    // chart config
    var chartData = [ChartData]()
    var startDate = Date()
    var endDate = Date()
    var minPrice = 0.0
    var maxPrice = 0.0
    var xAxisValues = [Date]()
    var yAxisValues = [Double]()
    
    var coinName: String {
        return coin.name
    }
    
    var chartLineColor: Color {
        let priceChange = (coin.sparklineIn7D?.price.last ?? 0) - (coin.sparklineIn7D?.price.first ?? 0)
        return priceChange > 0 ? .green : .red
    }
    
    init(coin: Coin) {
        self.coin = coin
        configureChartData()
        
        print("DEBUG: Coin is \(self.coinName)")
    }
    
    var overviewSectionModel: CoinDetailSectionModel {
        // price stats
        let price = coin.currentPrice.toCurrency()
        let pricePercentChange = coin.priceChangePercentage24H
        let priceStats = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
        
        // market cap stats
        let marketCap = coin.marketCap ?? 0
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap.formattedWithAbbreviations(), percentageChange: marketCapPercentChange)
        
        // rank stats
        let rank = coin.marketCapRank
        let rankStat = StatisticModel(title: "Rank", value: "\(rank)", percentageChange: nil)
        
        // volume stats
        let volume = coin.totalVolume ?? 0
        let volumeStat = StatisticModel(title: "Volume", value: volume.formattedWithAbbreviations(), percentageChange: nil)
        
        return CoinDetailSectionModel(title: "Overview", stats: [priceStats, marketCapStat, rankStat, volumeStat])
    }
    
    var additionalDetailsSectionModel: CoinDetailSectionModel {
        // 24H high
        let high = coin.high24H?.toCurrency() ?? "n/a"
        let highStat = StatisticModel(title: "24H High", value: high, percentageChange: nil)
        
        // 24H low
        let low = coin.low24H?.toCurrency() ?? "n/a"
        let lowStat = StatisticModel(title: "24H Low", value: low, percentageChange: nil)
        
        // 24H price change
        let priceChange24H = coin.priceChange24H.toCurrency()
        let percentChange24H = coin.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24H Price Change", value: priceChange24H, percentageChange: percentChange24H)
        
        // 24H market cap change
        let marketCapChange = coin.marketCapChange24H ?? 0
        let marketCapChangePercent = coin.marketCapChangePercentage24H
        let marketStat = StatisticModel(title: "24H Market Cap Chang", value: "$\(marketCapChange.formattedWithAbbreviations())", percentageChange: marketCapChangePercent)
        
        return CoinDetailSectionModel(title: "Additional Details", stats: [highStat, lowStat, priceChangeStat, marketStat])
    }
    
    func configureChartData() {
        guard let priceData = coin.sparklineIn7D?.price else { return }
        var index = 0
        self.minPrice = priceData.min()!
        self.maxPrice = priceData.max()!
        self.endDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        self.startDate = endDate.addingTimeInterval(-7 * 60 * 60 * 24)
        self.yAxisValues = [minPrice, (minPrice + maxPrice) / 2, maxPrice]
        self.xAxisValues = [startDate, endDate]
        
        for price in priceData.reversed() {
            let date = endDate.addingTimeInterval(-1 * 60 * 60 * Double(index))
            
            let chartDataItem = ChartData(date: date, value: price)
            self.chartData.append(chartDataItem)
            index += 1
        }
    }
}

/*
 
 loop thru prices backwards because we only have end date for time interval
 need to figure out date for each price point
 
 [10, 20, 30, 40] - prices
 
 i
 [40, 30, 20, 10] - prices reversed
 [4, 3, 2, 1] - dates (need to figure out how to do this)
 
 [(4, 40), (3, 30), .. ] - chart data (result)
 */
