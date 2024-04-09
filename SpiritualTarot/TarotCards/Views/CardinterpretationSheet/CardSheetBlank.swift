//
//  DailyCardSheetCoreDB.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 15.02.24.
//

import SwiftUI

// for the "Tarot School" 

struct CardSheetBlank: View {
    
    var oneCard: Card
        
    var body: some View {
        ScrollView {
            
            VStack {
                Text(oneCard.name!)
                    .font(.title)
                    .bold()
                    .foregroundColor(.purple)
                    .padding(.top, 15)
                
                Image(oneCard.image!)
                    .resizable()
                    .frame(width: 160, height: 250)
                    .shadow(radius: 10)
                
                HStack {
                    Text("Value:")
                    Text(oneCard.value!)
                        .foregroundColor(.purple)
                }
                .padding(.top, 5)
                .bold()
                
                HStack {
                    Text("Arcana:")
                    Text(oneCard.suite!)
                        .foregroundColor(.purple)
                }
                .bold()
                
                
                Text("Keywords:")
                    .padding(.top, 10)
                    .bold()
                Text(oneCard.keywords!)
                    .padding(.horizontal, 20)
                
                
                Text("Meaning:")
                    .padding(.top, 10)
                    .bold()
                Text(oneCard.meaning!)
                    .padding(.horizontal, 20)
                
                
                Text("Fortune Telling:")
                    .padding(.top, 10)
                    .bold()
                Text(oneCard.fortuneTelling!)
                    .padding(.horizontal, 20)
                
                
                Text("Questions to ask:")
                    .padding(.top, 10)
                    .bold()
                Text(oneCard.qTA!)
                    .padding(.horizontal, 20)
                
                
                Text("Description:")
                    .padding(.top, 10)
                    .bold()
                Text(oneCard.descript!)
                    .padding(.horizontal, 20)
                
                
            }
        }
        .background {
            LinearGradient(colors: [Color.mint.opacity(0.5), .purple.opacity(0.4), .mint.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        
    }
}

/*
#Preview {
    DailyCardSheetCoreDB()
}
*/
