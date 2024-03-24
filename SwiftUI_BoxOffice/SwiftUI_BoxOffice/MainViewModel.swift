//
//  MainViewModel.swift
//  SwiftUI_BoxOffice
//
//  Created by Dylan_Y on 3/7/24.
//

import Foundation

@MainActor
class MainViewModel: ObservableObject {
    private var api: BoxOfficeDailyAPI
    
    @Published var title: String
    @Published var data = [DailyBoxOfficeList]()
    @Published var date = Date()
    
    init() {
        self.title = Date().yesterday(with: true)
        self.api = BoxOfficeDailyAPI(targetDt: Date().yesterday(with: false))
        
        api.fetchData { listData in
            self.data = listData
        }
    }
    
    func numberFormatter(dateInfo: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        guard let numberAudiCnt = Int(dateInfo) else {
            return dateInfo
        }
        
        guard let formmatCnt = formatter.string(for: numberAudiCnt) else {
            return dateInfo
        }
        
        return formmatCnt
    }
    
    func changeData() {
        self.title = date.someDay(with: true)
        
        self.api = BoxOfficeDailyAPI(targetDt: Date().yesterday(with: false))
        
        api.fetchData { listData in
            self.data = listData
        }
    }
}
