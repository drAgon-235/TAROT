//
//  LoveOracleArchiveView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 19.02.24.
//

import SwiftUI

struct LoveOracleArchiveView: View {
    
    // Global variables for each card:
    let width: CGFloat
    let height: CGFloat
    
    // Variable for filling the cards with sense & logic:
    var cardIdList: [Int16]
    @StateObject var cardVM = CardViewModelCoreDB()

    // Variables for showing the "CardMeanig"-sheets:
    @State var showCardSheet01 = false
    @State var showCardSheet02 = false
    @State var showCardSheet03 = false
    @State var showCardSheet04 = false

    // Variables for displaying the infos about the saved Session, we get from the View above:
    let pathName: String
    let date: String
    let topic: String
    
    
    var body: some View {
        // the needed CardIDs to get the rigth card from the cardVM, according to the given parameter "cardIdList":
        let cardId01: Int = Int(cardIdList[0])
        let cardId02: Int = Int(cardIdList[1])
        let cardId03: Int = Int(cardIdList[2])
        let cardId04: Int = Int(cardIdList[3])

        // Start of outer VStack:
        VStack {
            
            // Start of inner VStack 1:
            VStack {
                HStack {
                    Text("Session from: ")
                        .foregroundColor(.orange)
                    Text(date)
                        .bold()
                }
                
                Text("Your issue was:")
                    .font(.title3)
                    .foregroundColor(.orange)
                Text(topic)
                
                Text(pathName)
                    .font(.title3)
                    .frame(width: 200, height: 30, alignment: .center)
                    .background(.blue)
                    .foregroundColor(Color.white.opacity(0.8))
                    .cornerRadius(10)
            }
            // End of inner VStack 1
            
            // Start of inner VStack 2:
            VStack {
                HStack {
                    VStack {
                        Text("3")
                        ZStack {
                            Image(cardVM.allCards[cardId03].image!)
                                .resizable()
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(.green.opacity(0.9), lineWidth: 3)
                        }
                        .frame(width: width, height: height)
                        Text("You")
                    }
                    .foregroundColor(.green)
                    .onTapGesture {
                        showCardSheet03.toggle()
                    }

                    
                }
                HStack(spacing: 30) {
                    VStack {
                        Text("1")
                        ZStack {
                            Image(cardVM.allCards[cardId01].image!)
                                .resizable()
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(.blue.opacity(0.9), lineWidth: 3)
                        }
                        .frame(width: width, height: height)
                        .padding(.horizontal, 40)
                        Text("Relationship")
                    }
                    .foregroundColor(.blue)
                    .onTapGesture {
                        showCardSheet01.toggle()
                    }
                    
                    VStack {
                        Text("2")
                        ZStack {
                            Image(cardVM.allCards[cardId02].image!)
                                .resizable()
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(.red.opacity(0.9), lineWidth: 3)
                        }
                        .frame(width: width, height: height)
                        .padding(.horizontal, 40)
                        Text("The other one")
                    }
                    .foregroundColor(.red)
                    .onTapGesture {
                        showCardSheet02.toggle()
                    }

                }
                HStack {
                    VStack {
                        Text("4")
                        ZStack {
                            Image(cardVM.allCards[cardId04].image!)
                                .resizable()
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(.purple.opacity(0.9), lineWidth: 3)
                        }
                        .frame(width: width, height: height)
                        Text("What to do")
                    }
                    .foregroundColor(.purple)
                    .onTapGesture {
                        showCardSheet04.toggle()
                    }
                }
            }
            // End of inner VStack 2
            // Coorective Element: ( without this we would have an ugly margin )
            RoundedRectangle(cornerRadius: 10.0)
                .frame(height: 30)
                .opacity(0)
            
        }
        // End of outer VStack
        .sheet( isPresented: $showCardSheet01){
            CardSheetExplanation(oneCard: cardVM.allCards[cardId01], givenText: "The Significator:\nThis card represents the \nrelationship, topic or question.")
        }
        
        .sheet( isPresented: $showCardSheet02){
            CardSheetExplanation(oneCard: cardVM.allCards[cardId02], givenText: "This card shows the other person.\nHer/his attitude, expectations, \nHis/her perspective on you.")
        }
        
        .sheet( isPresented: $showCardSheet03){
            CardSheetExplanation(oneCard: cardVM.allCards[cardId03], givenText: "This card represents your inner world. Hopes, anxieties, wishes, motivations. ")
        }
        
        .sheet( isPresented: $showCardSheet04){
            CardSheetExplanation(oneCard: cardVM.allCards[cardId04], givenText: "This card is your Oracle! \n It can be a proposal for an action  \nor attitude.")
        }
        // workaround to eliminate the big space under the Navigationtitle "Back"
        .padding(.top, 90)
        .ignoresSafeArea()
        .background (
            LinearGradient(colors: [Color.orange.opacity(0.4), .purple.opacity(0.3), .orange.opacity(0.4)], startPoint: .bottomTrailing, endPoint: .topLeading)
        )  // it makes a big difference, whether the brackets are round or curly !!!!

    }
}

#Preview {
    LoveOracleArchiveView(width: 80, height: 120, cardIdList: [1, 2, 3, 4], pathName: "Simple Path", date: "2027-Mar-4", topic: "Sonntagsfrage XXL")
}
