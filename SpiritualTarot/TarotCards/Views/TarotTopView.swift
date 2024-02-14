//
//  TarotTopView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import SwiftUI

struct TarotTopView: View {
    
    // Variables for showing the "Card of the day"-sheet:
    @State var showCardSheet01 = false
    
    // Variables for filling the cards with sense & logic:
    @StateObject var cardVM = CardViewModelCoreDB()

    
    var body: some View {
        NavigationStack {
            VStack {
                CardOfTheDayBTN(action: {
                    showCardSheet01.toggle()
                })
                
                
                NavigationLink(destination: AllPathsView()) {
                    SessionsBTN()
                }
               // .navigationBarTitle(Text("Tarot Cards"))

                
                    .toolbar {
                        HStack {
                            Spacer()
                            LogoutButtonAlert()
                        }
                    }
                
            }
        }
         
                .sheet( isPresented: $showCardSheet01){
                    // the first card from the shuffled deck = random card
                    OneCardSheetCoreDB(oneCard: cardVM.shuffledDeck().first!)
                    // optional:
                    Button("Close"){ showCardSheet01.toggle() }
                    //Spacer()
                }
            
    }
}

#Preview {
    TarotTopView()
}
