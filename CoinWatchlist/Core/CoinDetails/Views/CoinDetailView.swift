//
//  CoinDetailView.swift
//  CoinWatchlist
//
//  Created by Arif Siregar on 06/01/23.
//

import SwiftUI

struct CoinDetailView: View {
    let viewModel: CoinDetailViewModel
    
    init(coin: Coin) {
        self.viewModel = CoinDetailViewModel(coin: coin)
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            // chart
            ChartView(viewModel: viewModel)
                .frame(height: 250)
                .padding(.vertical)
                .shadow(color: viewModel.chartLineColor, radius: 10)
                .shadow(color: viewModel.chartLineColor.opacity(0.5), radius: 10)
            
            // overview
            CoinDetailsSection(model: viewModel.overviewSectionModel)
                .padding(.vertical)
            
            // additional details
            CoinDetailsSection(model: viewModel.additionalDetailsSectionModel)
                .padding(.vertical)
        }
        .padding()
        .navigationTitle(viewModel.coinName)
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailView(coin: dev.coin)
    }
}
