//
//  MainDetailView.swift
//  SwiftUI_BoxOffice
//
//  Created by Dylan_Y on 3/7/24.
//

import SwiftUI

struct MainDetailView: View {
    @ObservedObject var viewModel: MainDetailViewModel
    
    init(movieNm: String, movieCd: String) {
        self.viewModel = MainDetailViewModel(movieNm: movieNm, movieCd: movieCd)
    }
    
    var body: some View {
        NavigationStack{
            ScrollView {
                customImageView
                
                ForEach(viewModel.infoData) { id in
                    DetailTextView(title: id.title, detail: id.content)
                }
                .navigationTitle(viewModel.movieNm)
            }
        }
        .task {
            // View Appear 에서 비동기 작업
            viewModel.configureDetailData()
        }
    }
    
    private var customImageView: some View {
        Group {
            if let image = UIImage(data: viewModel.imageData ?? Data()) {
                Image(uiImage: image) // 데이터로 이미지 받는방법?..
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Spacer()
                ProgressView()
            }
        }
    }
}

struct DetailTextView: View {
    let title: String
    let detail: String
    
    var body: some View {
        VStack(alignment: .leading, content: {
            HStack() {
                Text(title)
                    .font(.title2)
                    .frame(minWidth: 70)
                    .padding(10)
                Text(detail)
                    .frame(alignment: .leading)
                    .padding(10)
                Spacer()
            }
        })
    }
}

#Preview {
    MainDetailView(movieNm: "파묘", movieCd: "20234675")
}
