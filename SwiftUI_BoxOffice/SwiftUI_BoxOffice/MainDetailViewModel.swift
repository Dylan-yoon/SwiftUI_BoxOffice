//
//  MainDetailViewModel.swift
//  SwiftUI_BoxOffice
//
//  Created by Dylan_Y on 3/8/24.
//

import Foundation

class MainDetailViewModel: ObservableObject {
    let movieNm: String
    let movieCd: String
    @Published var infoData = [InfoData]()
    @Published var imageData: Data?
    
    init(movieNm: String, movieCd: String) {
        self.movieNm = movieNm
        self.movieCd = movieCd
    }
    
    final class InfoData: Identifiable {
        let title: String
        let content: String
        
        init(title: String, content: String) {
            self.title = title
            self.content = content
        }
    }
    
    func configureDetailData() {
        BoxOfficeMovieDetailAPI(movieCd: movieCd).fetchData { movieInfo in
            self.configureImageData(movieTitle: movieInfo.movieNm)
            self.configureInfoData(movieInfoData: movieInfo)
        }
    }
    
    private func configureImageData(movieTitle: String) {
        KakaoAPI().fetchData(title: movieTitle) { imageData in
            
            guard let url = imageData.first?.imageUrl else {
                self.imageData = nil
                return
            }
            
            guard let url = URL(string: url) else {
                return
            }
            
            NetworkManager.shared.fetchData(for: url) { result in
                switch result {
                case .success(let data):
                    self.imageData = data
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func configureInfoData(movieInfoData: MovieInfo) {
        infoData = [
        InfoData(title: "감독", content: movieInfoData.directors.map { $0.peopleNm }.joined(separator: ", ")),
        InfoData(title: "제작년도", content: movieInfoData.prdtYear),
        InfoData(title: "개봉일", content: movieInfoData.openDt),
        InfoData(title: "상영시간", content: movieInfoData.showTm),
        InfoData(title: "관람등급", content: movieInfoData.audits.map { $0.watchGradeNm }.joined(separator: ", ")),
        InfoData(title: "제작국가", content: movieInfoData.nations.map { $0.nationNm }.joined(separator: ", ")),
        InfoData(title: "한국", content: movieInfoData.genres.map { $0.genreNm }.joined(separator: ", ")),
        InfoData(title: "배우", content: movieInfoData.actors.map { $0.peopleNm }.joined(separator: ", "))
        ]
    }
}

