//
//  CoinDetailsSection.swift
//  CoinWatchlist
//
//  Created by Arif Siregar on 06/01/23.
//

import SwiftUI

struct CoinDetailsSection: View {
    let model: CoinDetailSectionModel
    
    private let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack {
            Text(model.title)
                .font(.title).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                ForEach(model.stats) { data in
                    StatisticView(model: data)
                }
            }
            
        }
    }
}

struct CoinDetailsSection_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailsSection(model: dev.sectionModel)
    }
}
