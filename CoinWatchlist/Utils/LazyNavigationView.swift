//
//  LazyNavigationView.swift
//  CoinWatchlist
//
//  Created by Arif Siregar on 08/01/23.
//

import SwiftUI

struct LazyNavigationView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping() -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}
