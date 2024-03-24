//
//  CalendarView.swift
//  SwiftUI_BoxOffice
//
//  Created by Dylan_Y on 3/23/24.
//

import SwiftUI

struct CalendarView: View {
    @Binding var date: Date
    @Binding var showCalendar: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                showCalendar.toggle()
                print(date)
            }, label: {
                Text("Button")
            })
        }
        
        DatePicker("StartDate",
                   selection: $date,
                   in: (Date.now - 86400*365)...(Date.now - 86400),
                   displayedComponents: .date)
        .datePickerStyle(.graphical)
    }
}

#Preview {
    @State var date = Date()
    @State var showC = false
    return CalendarView(date: $date, showCalendar: $showC)
}
