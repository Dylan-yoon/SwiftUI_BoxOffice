//
//  MainViewModel.swift
//  SwiftUI_BoxOffice
//
//  Created by Dylan_Y on 3/7/24.
//

import Foundation

class MainViewModel: ObservableObject {
    private let api: BoxOfficeDailyAPI
    var title: String
    @Published var data = [DailyBoxOfficeList]()
    
    init() {
        self.title = Date().yesterday(with: true)
        self.api = BoxOfficeDailyAPI(targetDt: Date().yesterday(with: false))
        
        api.fetchData { listData in
            self.data = listData
        }
    }
}
