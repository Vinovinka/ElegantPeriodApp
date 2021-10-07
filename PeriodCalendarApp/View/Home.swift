//
//  Home.swift
//  PeriodCalendarApp
//
//  Created by Виктория Виноградова on 06.10.2021.
//

import SwiftUI

struct Home: View {
    @State var currentDate: Date = Date()
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                
                //Custom Date Picker
                CustomDatePicker(currentDate: $currentDate)
                
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
