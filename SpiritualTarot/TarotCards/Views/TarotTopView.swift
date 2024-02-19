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
                
                NavigationLink(destination: AllPathsTopView()) {
                    NavigationBTN(text: "Reading Sessions", color: Color.blue)
                }
                
                NavigationLink(destination: TarotSchoolTopView()) {
                    NavigationBTN(text: "Tarot School", color: Color.mint)            
                }
                
                NavigationLink(destination: ArchivedSessionsListView(width: 80, height: 120)) {
                    NavigationBTN(text: "Saved Sessions", color: Color.orange)
                }
                .navigationBarTitle(Text("Tarot Home"))

                
                .toolbar {
                    HStack {
                        Spacer()
                        LogoutButtonAlert()
                    }
                }
                
            }
        }
         
            // The daily/random Card:
                .sheet( isPresented: $showCardSheet01){
                    // the first card from the shuffled deck = random card
                    CardSheetExplanation( oneCard: cardVM.shuffledDeck().first!, givenText: "Your daily/random Card")
                    // optional:
                    Button("Close"){ showCardSheet01.toggle() }
                    // Spacer()
                }
            
    }
}

#Preview {
    TarotTopView()
}
