//
//  StatisticModel.swift
//  CoinWatchlist
//
//  Created by Arif Siregar on 07/01/23.
//

import Foundation

struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
}
