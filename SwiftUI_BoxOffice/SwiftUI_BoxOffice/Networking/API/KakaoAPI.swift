//
//  KakaoAPI.swift
//  SwiftUI_BoxOffice
//
//  Created by Dylan_Y on 3/7/24.
//

import Foundation

final class KakaoAPI {
    private let key = Bundle.main.kakaoKey
    
//    init(movieCd: String) {
//        self.movieCd = movieCd
//    }
    
    func fetchData(title: String, completion: @escaping ([KakaoDocuments]) -> Void) {
        
        guard let key = key else {
            return
        }
        
        let endpoint = EndPoint(baseURL: "dapi.kakao.com",
                                path: "/v2/search/image",
                                headers: ["Authorization":"KakaoAK \(key)"], 
                                method: .get)
        endpoint.add(queryItem: URLQueryItem(name: "query", value: title + "영화 포스터"))
//        endpoint.add(queryItem: URLQueryItem(name: "sort", value: "")) //accuracy(정확도순) 또는 recency(최신순), 기본 값 accuracy
//        endpoint.add(queryItem: URLQueryItem(name: "page", value: "1"))
//        endpoint.add(queryItem: URLQueryItem(name: "size", value: "1"))
        
        print(endpoint.generateURL())
        
        NetworkManager.shared.fetchData(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                do {
                    let kakaoDTO = try JSONDecoder().decode(KakaoImageDTO.self, from: data)
                    
                    completion(kakaoDTO.documents)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
