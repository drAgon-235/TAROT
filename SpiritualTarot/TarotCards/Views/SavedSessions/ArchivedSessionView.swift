//
//  ArchivedItemView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 17.02.24.
//

import SwiftUI

struct ArchivedSessionView: View {
    
    let date: String
    let reading: String

    var body: some View {
        VStack {
            HStack{
                Text(date)
                Spacer()
            }
            HStack {
                Spacer()
                Text(reading)
            }
        }  
    }
}

#Preview {
    ArchivedSessionView(date: "2024-Mar_27", reading: "App Developer Exam")
}
