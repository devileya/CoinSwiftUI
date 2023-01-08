//
//  Date.swift
//  CoinWatchlist
//
//  Created by Arif Siregar on 07/01/23.
//

import Foundation

extension Date {
    
//    "2023-01-07T13:10:04.484Z"
    init(coinGeckoString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGeckoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter
    }
    
    func asShortDateString() -> String {
        return shortDateFormatter.string(from: self)
    }
}
