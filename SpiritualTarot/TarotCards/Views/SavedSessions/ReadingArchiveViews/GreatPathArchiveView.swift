//
//  GreatPathArchiveView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 19.02.24.
//

import SwiftUI

struct GreatPathArchiveView: View {
    
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
    @State var showCardSheet05 = false
    @State var showCardSheet06 = false
    @State var showCardSheet07 = false

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
        let cardId05: Int = Int(cardIdList[4])
        let cardId06: Int = Int(cardIdList[5])
        let cardId07: Int = Int(cardIdList[6])

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
                Spacer()

                HStack {
                    VStack {
                        Text("PAST")
                            .foregroundColor(.blue)
                        Text("2")
                        ZStack {
                            Image(cardVM.allCards[cardId02].image!)
                                .resizable()
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(.purple.opacity(0.9), lineWidth: 3)
                        }
                        .frame(width: width, height: height)
                            Text(" objective\nawareness")
                                .font(.footnote)
                    }
                    .foregroundColor(.blue)
                    .onTapGesture {
                        showCardSheet02.toggle()
                    }
                    
                    VStack {
                        Text("1")
                        ZStack {
                            Image(cardVM.allCards[cardId01].image!)
                                .resizable()
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(.purple.opacity(0.9), lineWidth: 3)
                        }
                        .frame(width: width, height: height)
                            Text("Chance")
                                .foregroundColor(.green)
                    }
                    .foregroundColor(.green)
                    // positioning this stack a little bit higher, than the other 2 cards:
                    .offset(x: 0, y: -30)
                    // and exactly central:
                    .padding(.horizontal, 30)
                    .onTapGesture {
                        showCardSheet01.toggle()
                    }
                    
                    
                    VStack {
                        Text("FUTURE")
                        Text("7")
                        ZStack {
                            Image(cardVM.allCards[cardId07].image!)
                                .resizable()
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(.purple.opacity(0.9), lineWidth: 3)
                        }
                        .frame(width: width, height: height)
                            Text(" objective\nawareness")
                                .font(.footnote)
                    }
                    .foregroundColor(.red)
                    .onTapGesture {
                        showCardSheet07.toggle()
                    }
                }
                Spacer()
                
                HStack(spacing: 30) {
                    VStack {
                        Text("3")
                        ZStack {
                            Image(cardVM.allCards[cardId03].image!)
                                .resizable()
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(.purple.opacity(0.9), lineWidth: 3)
                        }
                        .frame(width: width, height: height)
                                .padding(.horizontal, 60)
                            Text("subjective\nemotions")
                                .font(.footnote)
                    }
                    .foregroundColor(.blue)
                    .onTapGesture {
                        showCardSheet03.toggle()
                    }

                    
                    VStack{
                        Text("6")
                        ZStack {
                            Image(cardVM.allCards[cardId06].image!)
                                .resizable()
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(.purple.opacity(0.9), lineWidth: 3)
                        }
                        .frame(width: width, height: height)
                                .padding(.horizontal, 60)
                            Text("subjective\nemotions")
                                    .font(.footnote)
                    }
                    .foregroundColor(.red)
                    .onTapGesture {
                        showCardSheet06.toggle()
                    }
                    
                }
                // space to upper HStack:
               // .padding(.top, 10)
                Spacer()
                
                HStack(spacing: 30) {
                    VStack {
                        Text("4")
                        ZStack {
                            Image(cardVM.allCards[cardId04].image!)
                                .resizable()
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(.purple.opacity(0.9), lineWidth: 3)
                        }
                        .frame(width: width, height: height)
                            .padding(.horizontal, 60)
                        Text("reality")
                            .font(.footnote)
                        
                    }
                    .foregroundColor(.blue)
                    .onTapGesture {
                        showCardSheet04.toggle()
                    }
                    
                    VStack{
                        Text("5")
                        ZStack {
                            Image(cardVM.allCards[cardId05].image!)
                                .resizable()
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(.purple.opacity(0.9), lineWidth: 3)
                        }
                        .frame(width: width, height: height)
                            .padding(.horizontal, 60)
                        Text("reality")
                            .font(.footnote)
                    }
                    .foregroundColor(.red)
                    .onTapGesture {
                        showCardSheet05.toggle()
                    }
                    
                }
                // Coorective Element:
                RoundedRectangle(cornerRadius: 10.0)
                    .frame(height: 30)
                    .opacity(0)
                Spacer()

            }
            // End of inner VStack 2

        }
        .padding(.bottom, 30)

        // End of outer VStack
        .sheet( isPresented: $showCardSheet01){
            CardSheetExplanation(oneCard: cardVM.allCards[cardId01], givenText: "This card represents the CHANCES  and GOALS at the end of your path. The possible outcome.")
        }
        
        .sheet( isPresented: $showCardSheet02){
            CardSheetExplanation(oneCard: cardVM.allCards[cardId02], givenText: "This card represents your CONSCIOUS attitude to this issue TODAY. Rational intentions, thaughts and actions. \n(compare to card 7)")
        }
        
        .sheet( isPresented: $showCardSheet03){
            CardSheetExplanation(oneCard: cardVM.allCards[cardId03], givenText: "This card stands for your UNCONSCIOUS realm. Your feelings, desires,estimations, (wrong) expectations! \n(compare to card 6)")
        }
        
        .sheet( isPresented: $showCardSheet04){
            CardSheetExplanation(oneCard: cardVM.allCards[cardId04], givenText: "This card shows your REALTY NOW. That's how others see you. That's what you don't know. \n(compare to card 5)")
        }
        
        .sheet( isPresented: $showCardSheet05){
            CardSheetExplanation(oneCard: cardVM.allCards[cardId05], givenText: "This card represents your  FUTURE REALITY. It suggests how to perform, shows what you may reveal. (compare to card 4)")
        }
        
        .sheet( isPresented: $showCardSheet06){
            CardSheetExplanation(oneCard: cardVM.allCards[cardId06], givenText: "This card suggests a direction for your emotions. It shows for what you should open your mind and heart. (compare to card 3)")
        }
        
        .sheet( isPresented: $showCardSheet07){
            CardSheetExplanation(oneCard: cardVM.allCards[cardId07], givenText: "This card suggests, on what you should focus your thaughts and actions in FUTURE CONSCIOUSLY.\n(compare to card 2)")
        }
        // workaround to eliminate the big space under the Navigationtitle "Back"
        .padding(.top, 90)
        .ignoresSafeArea()
        .background(Color.orange.opacity(0.2))

    }
}

#Preview {
    GreatPathArchiveView(width: 80, height: 120, cardIdList: [1, 2, 3, 4, 5, 6, 7], pathName: "Simple Path", date: "2027-Mar-4", topic: "Sonntagsfrage XXL")
}
