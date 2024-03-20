//
//  DateTodayView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 26.01.24.
//

import SwiftUI

struct DateTodayView: View {
    
    func getCurrentWeekDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // The full weekday name
        return formatter.string(from: Date())
    }
    
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy" // MMM: short month name
        return formatter.string(from: Date())
    }
    
    
    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(colors: [Color.orange, Color.purple, Color.orange]), startPoint: .leading, endPoint: .trailing)
                .frame(height: 3)
                .padding(.horizontal, 120)
            
            Text(getCurrentWeekDay())
                .font(.title2)

            Text(getCurrentDate())
                .font(.title3)
            
            LinearGradient(gradient: Gradient(colors: [Color.orange, Color.purple, Color.orange]), startPoint: .leading, endPoint: .trailing)
                .frame(height: 3)
                .padding(.horizontal, 120)
        }
        .foregroundColor(.purple)
    }
}

#Preview {
    DateTodayView()
}
