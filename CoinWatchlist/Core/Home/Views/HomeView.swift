//
//  HomeView.swift
//  CoinWatchlist
//
//  Created by Arif Siregar on 06/01/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    // top movers view
                    TopMoversView(viewModel: viewModel)
                    
                    Divider()
                    
                    // all coins view
                    AllCoinsView(viewModel: viewModel)
                }
                .navigationTitle("Live Prices")
                
                if viewModel.isLoadingData {
                    CustomLoadingIndicator()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
