//
//  ChartData.swift
//  CoinWatchlist
//
//  Created by Arif Siregar on 07/01/23.
//

import Foundation

struct ChartData: Identifiable {
    let id = UUID().uuidString
    let date: Date
    let value: Double
}
