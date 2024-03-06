//
//  BoxOfficeDTO.swift
//  SwiftUI_BoxOffice
//
//  Created by Dylan_Y on 3/6/24.
//

import Foundation

struct BoxOfficeDTO: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let rnum: String
    let rank: String
    let rankInten: String
    let rankOldAndNew: RankOldAndNew
    let movieCd: String
    let movieNm: String
    let openDt: String
    let salesAmt: String
    let salesShare: String
    let salesInten: String
    let salesChange: String
    let salesAcc: String
    let audiCnt: String
    let audiInten: String
    let audiChange: String
    let audiAcc: String
    let scrnCnt: String
    let showCnt: String
    
    enum CodingKeys: String, CodingKey {
        case rnum
        case rank
        case rankInten
        case rankOldAndNew
        case movieCd
        case movieNm
        case openDt
        case salesAmt
        case salesShare
        case salesInten
        case salesChange
        case salesAcc
        case audiCnt
        case audiInten
        case audiChange
        case audiAcc
        case scrnCnt
        case showCnt
    }
}

enum RankOldAndNew: String, Codable {
    case new = "NEW"
    case old = "OLD"
}
