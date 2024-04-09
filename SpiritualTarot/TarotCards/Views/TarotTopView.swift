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
            ZStack {
                Image("aaa_stars01").resizable().scaledToFill().opacity(0.8)
                
            VStack {
                CardOfTheDayBTN(action: {
                    showCardSheet01.toggle()
                })
                .shadow(radius: 10)

                
                NavigationLink(destination: AllPathsTopView()) {
                    NavigationBTN(text: "Reading Sessions", color: Color.blue)
                }
                .shadow(radius: 10)

                
                NavigationLink(destination: TarotSchoolTopView()) {
                    NavigationBTN(text: "Tarot School", color: Color.mint)            
                }
                .shadow(radius: 10)
                
                NavigationLink(destination: ArchivedSessionsListView(width: 80, height: 120)) {
                    NavigationBTN(text: "Saved Sessions", color: Color.orange)
                }
                .shadow(radius: 10)

               // .navigationBarTitle(Text("Tarot Home"))

                
                .toolbar {
                    HStack {
                        Spacer()
                        LogoutButtonAlert(color: Color.white)
                    }
                }
                
                
/*
                .toolbar(content: {
                    Menu {
                        Text("Instruction:")
                        Text("1. Click 'SHUFFLE' button. ")
                        Text("2. Click 'READING' button.")
                        Text("3. Click each card to see the interpretation.")
                        Text("4. (optional) Click the 'SAVE' button to save a session.")
                       
                        Button  {
                            
                        } label: {
                            LogoutButtonAlert(color: Color.white)
                        }
                        
  
                    } label: {
                        Label("info", systemImage: "info.circle")
                    }
                })
*/
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

//  aaastars02
