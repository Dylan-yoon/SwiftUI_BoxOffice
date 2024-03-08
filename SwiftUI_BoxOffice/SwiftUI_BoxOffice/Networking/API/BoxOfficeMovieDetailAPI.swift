//
//  BoxOfficeMovieDetailAPI.swift
//  SwiftUI_BoxOffice
//
//  Created by Dylan_Y on 3/7/24.
//

import Foundation

final class BoxOfficeMovieDetailAPI {
    private let key = Bundle.main.boxofficeKey
    private let movieCd: String
    
    init(movieCd: String) {
        self.movieCd = movieCd
    }
    
    func fetchData(completion: @escaping (MovieInfo) -> Void) {
        
        let endpoint = EndPoint(baseURL: "www.kobis.or.kr",
                                path: "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json",
                                method: .get)
        guard let key = key else {
            return
        }
        
        endpoint.add(queryItem: URLQueryItem(name: "key", value: key))
        endpoint.add(queryItem: URLQueryItem(name: "movieCd", value: movieCd))
        
        NetworkManager.shared.fetchData(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                do {
                    let boxOfficeMovieDetailDTO = try JSONDecoder().decode(BoxOfficeMovieDetailDTO.self, from: data)
                    
                    completion(boxOfficeMovieDetailDTO.movieInfoResult.movieInfo)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
