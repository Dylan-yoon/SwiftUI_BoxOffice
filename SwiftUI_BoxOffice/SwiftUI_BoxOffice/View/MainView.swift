//
//  ContentView.swift
//  SwiftUI_BoxOffice
//
//  Created by Dylan_Y on 3/6/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = MainViewModel()
    @State private var showCalendar = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.data.indices, id: \.self) { index in
                    NavigationLink {
                        MainDetailView(movieNm: viewModel.data[index].movieNm, movieCd: viewModel.data[index].movieCd)
                    } label: {
                        RankCell(movieData: viewModel.data[index])
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle(Text(viewModel.title))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showCalendar.toggle()
                    }, label: {
                        Text("날짜 선택")
                    })
                    .sheet(isPresented: $showCalendar, content: {
                        //캘린더뷰
                        CalendarView(date: $viewModel.date, showCalendar: $showCalendar)
                            .onDisappear(perform: {
                                viewModel.changeData()
                            })
                    })
                }
            }
        }
    }
}

struct RankCell: View {
    var movieData: DailyBoxOfficeList
    var audiCnt: String
    var audiAcc: String
    
    init(movieData: DailyBoxOfficeList) {
        self.movieData = movieData
        
        self.audiCnt = movieData.audiCnt
        self.audiAcc = movieData.audiAcc
        
        self.audiCnt = numberFormatter(data: movieData.audiCnt)
        self.audiAcc = numberFormatter(data: movieData.audiAcc)
    }
    
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
                
                Text("오늘 \(audiCnt) / 총 \(audiAcc)")
                    .font(.title3)
            }
            Spacer()
        }
    }
    
    private func numberFormatter(data: String) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
//        
//        guard let numberAudiCnt = Int(movieData.audiCnt),
//              let numberAudiAcc = Int(movieData.audiAcc) else {
//            return
//        }
//        
//        guard let formmatCnt = formatter.string(for: numberAudiCnt),
//              let formmatAcc = formatter.string(for: numberAudiAcc) else {
//            return
//        }
//        
//        self.audiCnt = formmatCnt
//        self.audiAcc = formmatAcc
        
        guard let numberAudiCnt = Int(data) else {
            return data
        }
        
        guard let formmatCnt = formatter.string(for: numberAudiCnt) else {
            return data
        }
        
        return formmatCnt
    }
}

#Preview {
    MainView()
}
