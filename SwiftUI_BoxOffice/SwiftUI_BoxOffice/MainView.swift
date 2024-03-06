//
//  ContentView.swift
//  SwiftUI_BoxOffice
//
//  Created by Dylan_Y on 3/6/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewmodel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            Text(viewmodel.title)
            
            List {
                ForEach(viewmodel.data.indices, id: \.self) { index in
                    RankCell(movieData: $viewmodel.data[index])
                        .badge(">")
                }
            }
            .listStyle(.plain)
        }
    }
}

struct RankCell: View {
    @Binding var movieData: DailyBoxOfficeList
    
    var body: some View {
        
        HStack {
            VStack {
                Text(movieData.rank)
                    .font(.largeTitle)
                RankCellDetailView(movieData: movieData)
            }
            .padding(10)
            
            VStack(alignment: .leading) {
                Text(movieData.movieNm)
                    .font(.title2)
                
                Text("오늘 \(movieData.audiCnt) / 총 \(movieData.audiAcc)")
                    .font(.title3)
            }
            Spacer()
        }
    }
}

#Preview {
    MainView()
}
