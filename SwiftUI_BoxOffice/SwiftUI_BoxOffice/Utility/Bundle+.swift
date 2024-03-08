//
//  Bundle+.swift
//  SwiftUI_BoxOffice
//
//  Created by Dylan_Y on 3/7/24.
//

import Foundation

extension Bundle {
    
    var boxofficeKey: String? {
        guard let file = self.path(forResource: "Secrets", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["BoxOffice_Key"] as? String else {
            print("⛔️ BoxOffice Key를 가져오는데 실패하였습니다.")
            return nil
        }
        return key
    }
    
    var kakaoKey: String? {
        guard let file = self.path(forResource: "Secrets", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["Kakao_Key"] as? String else {
            print("⛔️ Kakao_Key Key를 가져오는데 실패하였습니다.")
            return nil
        }
        return key
    }
}
