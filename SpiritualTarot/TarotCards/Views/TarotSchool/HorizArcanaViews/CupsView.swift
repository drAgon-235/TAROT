//
//  CupsView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 15.02.24.
//

import SwiftUI

struct CupsView: View {
    
    @StateObject private var cardVM = CardViewModelCoreDB()
    
    @State var showCardSheet01 = false
   
    var body: some View {
        // the default card for our "details-sheet"
        var cardForSheet: Card = cardVM.allCards.first!
        VStack {
            Spacer()
            Text("Tap the card to learn more about it")
            Spacer()
            ScrollView(.horizontal) {
                HStack {
                    ForEach(cardVM.allCards) { thisCard in
                        if thisCard.suite == "Cups" {
                            VStack {
                                Text("\(thisCard.value!)")
                                Image(thisCard.image!)
                                    .resizable()
                                    .frame(width: 100, height: 160)
                                    .shadow(radius: 10)
                                Text(thisCard.name ?? "No Value found")
                            }
                            .foregroundColor(.purple)
                            .bold()
                            .onTapGesture {
                                cardForSheet = thisCard
                                showCardSheet01.toggle()
                            }
                        }
                        
                    }
                    .padding()
                    
                }
                
            }
            
            Spacer()
        }
        
        .sheet( isPresented: $showCardSheet01){
            CardSheetBlank(oneCard: cardForSheet)
        }
        
    }
}

#Preview {
    CupsView()
}
