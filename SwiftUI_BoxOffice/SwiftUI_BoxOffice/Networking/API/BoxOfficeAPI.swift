//
//  BoxOfficeAPI.swift
//  SwiftUI_BoxOffice
//
//  Created by Dylan_Y on 3/6/24.
//

import Foundation

final class BoxOfficeDailyAPI {
    private let key = Bundle.main.boxofficeKey
    private let targetDt: String
    private let itemPerPage: Int
    private let multMovieYn: String?
    private let repNationCd: String?
    private let wideAreaCd: String?
    
    init(targetDt: String,
         itemPerPage: Int = 10,
         multMovieYn: String? = nil,
         repNationCd: String? = nil,
         wideAreaCd: String? = nil) {
        self.targetDt = targetDt
        self.itemPerPage = itemPerPage
        self.multMovieYn = multMovieYn
        self.repNationCd = repNationCd
        self.wideAreaCd = wideAreaCd
    }
    
    func fetchData(completion: @escaping ([DailyBoxOfficeList]) -> Void) {
        
        let endpoint = EndPoint(baseURL: "www.kobis.or.kr",
                                path: "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
                                method: .get)
        guard let key = key else {
            return
        }
        
        endpoint.add(queryItem: URLQueryItem(name: "key", value: key))
        endpoint.add(queryItem: URLQueryItem(name: "targetDt", value: targetDt))
        endpoint.add(queryItem: URLQueryItem(name: "itemPerPage", value: String(itemPerPage)))
        endpoint.add(queryItem: URLQueryItem(name: "multMovieYn", value: multMovieYn))
        endpoint.add(queryItem: URLQueryItem(name: "repNationCd", value: repNationCd))
        endpoint.add(queryItem: URLQueryItem(name: "wideAreaCd", value: wideAreaCd))
        
        NetworkManager.shared.fetchData(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                do {
                    let boxOfficeDTO = try JSONDecoder().decode(BoxOfficeDTO.self, from: data)
                    completion(boxOfficeDTO.boxOfficeResult.dailyBoxOfficeList)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

/*
 key    문자열(필수)    발급받은키 값을 입력합니다.
 
 targetDt    문자열(필수)    조회하고자 하는 날짜를 yyyymmdd 형식으로 입력합니다.
 
 itemPerPage    문자열    결과 ROW 의 개수를 지정합니다.(default : “10”, 최대 : “10“)
 
 multiMovieYn    문자열    다양성 영화/상업영화를 구분지어 조회할 수 있습니다.
                        “Y” : 다양성 영화 “N” : 상업영화 (default : 전체)
 
 repNationCd    문자열    한국/외국 영화별로 조회할 수 있습니다.
                        “K: : 한국영화 “F” : 외국영화 (default : 전체)
 
 wideAreaCd    문자열    상영지역별로 조회할 수 있으며, 지역코드는 공통코드 조회 서비스에서 “0105000000” 로서 조회된 지역코드입니다. (default : 전체)
 */
