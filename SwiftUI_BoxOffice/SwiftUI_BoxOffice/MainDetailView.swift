//
//  MainDetailView.swift
//  SwiftUI_BoxOffice
//
//  Created by Dylan_Y on 3/7/24.
//

import SwiftUI

struct MainDetailView: View {
    let a = BoxOfficeMovieDetailAPI(movieCd: "20234675")
    
    let data: BoxOfficeMovieDetailDTO?
    
    var body: some View {
        ScrollView {
            Image(systemName: "heart")
            
//            DetailTextView(title: , detail: <#T##String#>)
            
        }
    }
}

#Preview {
    MainDetailView(data: nil)
}

struct DetailTextView: View {
    let title: String
    let detail: String
    
    var body: some View {
        HStack {
            Text(title)
            Text(detail)
        }
    }
}
