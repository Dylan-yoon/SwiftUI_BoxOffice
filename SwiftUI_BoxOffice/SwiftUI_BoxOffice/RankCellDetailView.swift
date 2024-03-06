//
//  RankCellDetailView.swift
//  SwiftUI_BoxOffice
//
//  Created by Dylan_Y on 3/7/24.
//

import SwiftUI

struct RankCellDetailView: View {
    let movieData: DailyBoxOfficeList
    
    var body: some View {
        HStack {
            switch movieData.rankOldAndNew {
            case .new:
                Text("신작")
                    .foregroundStyle(.red)
                    .font(.title3)
            case .old:
                let rankTier = Int(movieData.rankInten)!
                
                HStack(alignment: .center) {
                    if rankTier < 0 {
                        Image(systemName: "arrowtriangle.down.fill")
                            .foregroundStyle(.red)
                        Text(String(abs(rankTier)))
                    } else if rankTier > 0 {
                        Image(systemName: "arrowtriangle.up.fill")
                            .foregroundStyle(.blue)
                            .padding(0)
                        Text(String(abs(rankTier)))
                            .padding(0)
                    } else {
                        Image(systemName: "minus")
                    }
                }
            }
        }
    }
}

//#Preview {
//    RankCellDetailView()
//}
