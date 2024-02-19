//
//  SimplePathArchiveView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 17.02.24.
//

import SwiftUI

struct SimplePathArchiveView: View {
    
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

    // Variables for displaying the infos about the saved Session, we get from the View above:
    let pathName: String
    let date: String
    let topic: String
    
    var body: some View {
        // the needed CardIDs to get the rigth card from the cardVM, according to the given parameter "cardIdList":
        let cardId01: Int = Int(cardIdList[0])
        let cardId02: Int = Int(cardIdList[1])
        let cardId03: Int = Int(cardIdList[2])
        VStack {
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
       
            
            Spacer()
            VStack {
                HStack(spacing: 30) {
                    VStack {
                        Text("2")
                        ZStack {
                            Image(cardVM.allCards[cardId02].image!)
                                .resizable()
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(.red.opacity(0.9), lineWidth: 3)
                        }
                        .frame(width: width, height: height)
                        Text("PAST")
                    }
                    .foregroundColor(.red)
                    .onTapGesture {
                        showCardSheet02.toggle()
                    }
                    
                    VStack {
                        Text("1")
                        ZStack {
                            Image(cardVM.allCards[cardId01].image!)
                                .resizable()
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(.blue.opacity(0.9), lineWidth: 3)
                        }
                        .frame(width: width, height: height)
                        Text("PRESENT")
                    }
                    .foregroundColor(.blue)
                    .onTapGesture {
                        showCardSheet01.toggle()
                    }
                    
                    VStack {
                        Text("3")
                        ZStack {
                            Image(cardVM.allCards[cardId03].image!)
                                .resizable()
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(.green.opacity(0.9), lineWidth: 3)
                        }
                        .frame(width: width, height: height)
                        Text("FUTURE")
                    }
                    .foregroundColor(.green)
                    .onTapGesture {
                        showCardSheet03.toggle()
                    }
                }
            }
            Spacer()
            
                .sheet( isPresented: $showCardSheet01){
                    CardSheetExplanation(oneCard: cardVM.allCards[cardId01], givenText: "This card represents the PRESENT. \nThe actual situation / issue. \nWhat it's all about.")
                }
            
                .sheet( isPresented: $showCardSheet02){
                    CardSheetExplanation(oneCard: cardVM.allCards[cardId02], givenText: "This card represents the PAST \nand it's influence for the issue. \nThe root cause for the actual situation. ")
                }
            
                .sheet( isPresented: $showCardSheet03){
                    CardSheetExplanation(oneCard: cardVM.allCards[cardId03], givenText: "This card represents the FUTURE. \nThe direction it all evolves to. \nThe outcome.")
                }
        }
        // workaround to eliminate the big space under the Navigationtitle "Back"
        .padding(.top, 90)
        .ignoresSafeArea()
    }
}

#Preview {
    SimplePathArchiveView(width: 80, height: 120, cardIdList: [1, 2, 3], pathName: "Simple Path", date: "2027-Mar-4", topic: "Sonntagsfrage XXL")
}
