//
//  Date+.swift
//  SwiftUI_BoxOffice
//
//  Created by Dylan_Y on 3/7/24.
//

import Foundation

extension Date {
    func yesterday(with dash: Bool) -> String {
        let date = Date()
        guard let yesterdate = Calendar.current.date(byAdding: .day, value: -1, to: date) else {
            return "20240101"
        }
        
        let formatter = DateFormatter()
        if dash {
            formatter.dateFormat = "yyyy-MM-dd"
        } else {
            formatter.dateFormat = "yyyyMMdd"
        }
        
        let current_date_string = formatter.string(from: yesterdate)
        
        return current_date_string
    }
    
    func someDay(with dash: Bool) -> String {
        guard let today = Calendar.current.date(byAdding: .day, value: 0, to: self) else {
            return "20240101"
        }
        
        let formatter = DateFormatter()
        if dash {
            formatter.dateFormat = "yyyy-MM-dd"
        } else {
            formatter.dateFormat = "yyyyMMdd"
        }
        
        let current_date_string = formatter.string(from: today)
        
        return current_date_string
    }
}
