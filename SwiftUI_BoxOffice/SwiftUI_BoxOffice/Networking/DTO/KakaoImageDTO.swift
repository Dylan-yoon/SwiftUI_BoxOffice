//
//  KakaoImageDTO.swift
//  SwiftUI_BoxOffice
//
//  Created by Dylan_Y on 3/7/24.
//

import Foundation

struct KakaoImageDTO: Codable {
    let documents: [KakaoDocuments]
}

struct KakaoDocuments: Codable {
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
    }
}
