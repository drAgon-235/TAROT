//
//  OneCardSheetCoreDB.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 14.02.24.
//

import SwiftUI

struct CardSheetExplanation: View {
    
    var oneCard: Card
    
    let givenText: String
    
    var body: some View {
        ScrollView {
            ZStack {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(.mint.opacity(0.2))
                    .stroke(.purple.opacity(0.9), lineWidth: 3)
                
                Text(givenText)
                    .padding()
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
            }
            .padding()
            
            VStack {
                Text(oneCard.name!)
                    .font(.title)
                    .bold()
                    .foregroundColor(.purple)
                    //.shadow(radius: 1)
                    
                
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
            LinearGradient(colors: [Color.orange.opacity(0.5), .purple.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}

/*
 #Preview {
 OneCardSheetCoreDB()
 }
 */
