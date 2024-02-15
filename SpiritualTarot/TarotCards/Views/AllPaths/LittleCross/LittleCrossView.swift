//
//  LittleCrossView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 15.02.24.
//

import SwiftUI

struct LittleCrossView: View {
    
    // Global variables for each card:
    let width: CGFloat
    let height: CGFloat
    
    
    // Variables for the ShuffleAnimViews:
    @State var isFlippedShuffle = false
    @State var readingBtnIsVisible = false

    @State var backDegree_01 = 0.0
    @State var backDegree_02 = 0.0
    @State var backDegree_03 = 360
    
    @State var frontDegree_A = -90.0
    @State var backDegree_A = 0.0
    
    let durationAndDelay_01: CGFloat = 0.7
    let durationAndDelay_02: CGFloat = 0.9
    let durationAndDelay_03: CGFloat = 0.5
    let durationAndDelay_A: CGFloat = 0.4

    // After clicking Shuffle Button:
    func shuffleCards() {
        isFlippedShuffle.toggle()
        readingBtnIsVisible = true // once & forever
        
        if isFlippedShuffle {
            withAnimation(.linear(duration: durationAndDelay_A)) {
                backDegree_A = 180
            }
            withAnimation(.linear(duration: durationAndDelay_A)) {
                frontDegree_A = 270
            }
            
            withAnimation(.linear(duration: durationAndDelay_01)) {
                backDegree_01 = -360
            }
            withAnimation(.linear(duration: durationAndDelay_02)) {
                backDegree_02 = 360
            }
            withAnimation(.linear(duration: durationAndDelay_03)) {
                backDegree_03 = -360
            }
            
        } else {
            withAnimation(.linear(duration: durationAndDelay_A)) {
                backDegree_A = 0
            }
            withAnimation(.linear(duration: durationAndDelay_A)) {
                frontDegree_A = -270
            }
            
            withAnimation(.linear(duration: durationAndDelay_01)) {
                backDegree_01 = 0
            }
            withAnimation(.linear(duration: durationAndDelay_02)) {
                backDegree_02 = 0
            }
            withAnimation(.linear(duration: durationAndDelay_03)) {
                backDegree_03 = 0
            }
  
        }
    }
    
    
    // Variables for CardFlipView when rading button is clicked::
    @State var isFlippedReading = false
    @State var backDegreeReading = 0.0
    @State var frontDegreeReading = -90.0
    
    let durationAndDelay: CGFloat = 1.0
    let durationAndDelay2: CGFloat = 1.6

    @Namespace private var readingCard01
    @Namespace private var readingCard02
    @Namespace private var readingCard03
    @Namespace private var readingCard04

    @State private var move = false
    
    // After clicking Reading Button:
    func flipFlowingCard() {
        // The parameters make the turn animation slower or faster for each card:
        isFlippedReading = true
        if isFlippedReading {
            withAnimation(.linear(duration:
                durationAndDelay).delay(durationAndDelay2)) {
                backDegreeReading = 90
            }
            withAnimation(.linear(duration:
                durationAndDelay).delay(durationAndDelay2)) {
                frontDegreeReading = 0
            }
        } else {  }
    }
    
    
    // Variables for showing the "CardMeanig"-sheet:
    @State var showCardSheet01 = false
    @State var showCardSheet02 = false
    @State var showCardSheet03 = false
    @State var showCardSheet04 = false


    // corresponding functions:
    private func toggleCard01Sheet() {
        showCardSheet01.toggle()
    }
    
    private func toggleCard02Sheet() {
        showCardSheet02.toggle()
    }
    
    private func toggleCard03Sheet() {
        showCardSheet03.toggle()
    }

    private func toggleCard04Sheet() {
        showCardSheet04.toggle()
    }

    
    // Variables for filling the cards with sense & logic:
    @StateObject var cardVM = CardViewModelCoreDB()

    func shuffleDeck() -> [Card] {
        // our freshly shuffled deck:
        let shuffledDeck = cardVM.shuffledDeck()
        return shuffledDeck
    }
    
    
    var body: some View {
        // our freshly shuffled deck:
        @State var shuffledDeck = shuffleDeck()

        VStack{
            HStack {
                ZStack{
                    // the magic of moving and disappearing buttons:
                    if move {
                        ActionBTN(text: "Interprete", action: {}, action_02: {}, action_03: {})
                            .padding(40)
                    } else {
                        ActionBTN(text: "Shuffle",
                                  action: shuffleCards,
                                  action_02: {cardVM.justShuffle()}, // this action makes the Deck really shuffle each time you click the BTN
                                  // you see the result: every time another card is flipping !!! This is Perfection !!!
                                  action_03: {})
                        
                            .padding(40)
                        // Optional Query-Text for repetition of shuffling:
                        if readingBtnIsVisible {
                            Text("one more \ntime")
                                .padding(.top, 90)
                                .foregroundColor(.gray)
                        } else {  }
                    }
    
                }
                
                ZStack {
                    // All the cards to be read in the back - I love ZStacks:
                    // Card 1 - Front & Back:
                    CardBackTurn(theWidth: width, theHeight: height, myDegree: $backDegreeReading)
                        .matchedGeometryEffect(id: "card_basic1", in: readingCard01, isSource: false)
                    CardFrontTurn(theWidth: width, theHeight: height, myDegree: $frontDegreeReading, card: shuffledDeck[0])
                        .matchedGeometryEffect(id: "card_basic1", in: readingCard01, isSource: false)
                    // & the corresponding [transparent] button (appears just when card is laid out):
                    TransparentCardBTN(action: toggleCard01Sheet )
                        .matchedGeometryEffect(id: "card_basic1", in: readingCard01, isSource: false)

                    
                    // Card 2 - Front & Back:
                    CardBackTurn(theWidth: width, theHeight: height, myDegree: $backDegreeReading)
                        .matchedGeometryEffect(id: "card_basic2", in: readingCard02, isSource: false)
                    CardFrontTurn(theWidth: width, theHeight: height, myDegree: $frontDegreeReading, card: shuffledDeck[1])
                        .matchedGeometryEffect(id: "card_basic2", in: readingCard02, isSource: false)
                    // & the corresponding [transparent] button (appears just when card is laid out):
                    TransparentCardBTN(action: toggleCard02Sheet )
                        .matchedGeometryEffect(id: "card_basic2", in: readingCard02, isSource: false)
                    
                    // Card 3 - Front & Back:
                    CardBackTurn(theWidth: width, theHeight: height, myDegree: $backDegreeReading)
                        .matchedGeometryEffect(id: "card_basic3", in: readingCard03, isSource: false)
                    CardFrontTurn(theWidth: width, theHeight: height, myDegree: $frontDegreeReading, card: shuffledDeck[2])
                        .matchedGeometryEffect(id: "card_basic3", in: readingCard03, isSource: false)
                    // & the corresponding [transparent] button (appears just when card is laid out):
                    TransparentCardBTN(action: toggleCard03Sheet )
                        .matchedGeometryEffect(id: "card_basic3", in: readingCard03, isSource: false)
                    
                    // Card 4 - Front & Back:
                    CardBackTurn(theWidth: width, theHeight: height, myDegree: $backDegreeReading)
                        .matchedGeometryEffect(id: "card_basic4", in: readingCard04, isSource: false)
                    CardFrontTurn(theWidth: width, theHeight: height, myDegree: $frontDegreeReading, card: shuffledDeck[3])
                        .matchedGeometryEffect(id: "card_basic4", in: readingCard04, isSource: false)
                    // & the corresponding [transparent] button (appears just when card is laid out):
                    TransparentCardBTN(action: toggleCard04Sheet )
                        .matchedGeometryEffect(id: "card_basic4", in: readingCard04, isSource: false)
                    
                    
                    // The twisting cards on top:
                    // The "fake" cards (no front-picture) on the bottom (in the background)
                    CardBackTwist(theWidth: width, theHeight: height, myDegree: $backDegree_01)
                    CardBackTwist(theWidth: width, theHeight: height, myDegree: $backDegree_02)
                    CardBackTwist(theWidth: width, theHeight: height, myDegree: $backDegree_02)
                    // The only "real" card on top, otherwise you don't really see the rotation of the "Wheel of Fortune"
                    CardBackTurn(theWidth: width, theHeight: height, myDegree: $backDegree_A)
                    CardFrontTurn(theWidth: width, theHeight: height, myDegree: $frontDegree_A, card: shuffledDeck[11])

                    
                }
                //.padding( 20)
                
                // Thanks to the Holy Spirit for this logic (NO ChatGPT!):
                if !move {
                    if readingBtnIsVisible {
                        // active 'Readings button' for further pseudo-navigation by action:
                        ActionBTN(text: "Reading", action: {
                            // this anim finally makes the cards come down slowly:
                            withAnimation(.easeIn(duration: 1.1)) {
                                move = true
                                     // only once & forever
                            }}, action_02: flipFlowingCard, action_03: {})
                            .padding(.leading, 35)
                            .padding(.trailing, 20)
                    } else {
                        // inactive placeholder:
                        InactiveBTN(text: "Reading")
                            .padding(.leading, 35)
                            .padding(.trailing, 20)
                    }
                } else {}
                
            }
            .padding(.trailing, 15)
            // End of HStack on top of view
            
            Spacer()
            VStack {
                HStack {
                    VStack {
                        Text("3")
                        RoundedRectangle(cornerRadius: 20.0)
                            .stroke(.green.opacity(0.9), lineWidth: 3)
                            .matchedGeometryEffect(id:  move ? "card_basic3" : "", in: readingCard03, isSource: true)
                            .frame(width: width, height: height)
                        Text("Do that!")
                    }
                    .foregroundColor(.green)

                    
                }
                HStack(spacing: 30) {
                    VStack {
                        Text("1")
                        RoundedRectangle(cornerRadius: 20.0)
                            .stroke(.blue.opacity(0.9), lineWidth: 3)
                            .matchedGeometryEffect(id: move ? "card_basic1" : "", in: readingCard01, isSource: true)
                            .frame(width: width, height: height)
                            .padding(.horizontal, 40)
                        Text("It's about...")
                    }
                    .foregroundColor(.blue)

                    
                    VStack {
                        Text("2")
                        RoundedRectangle(cornerRadius: 20.0)
                            .stroke(.red.opacity(0.9), lineWidth: 3)
                            .matchedGeometryEffect(id: move ? "card_basic2" : "", in: readingCard02, isSource: true)
                            .frame(width: width, height: height)
                            .padding(.horizontal, 40)
                        Text("Don't do that")
                    }
                    .foregroundColor(.red)

                }
                HStack {
                    VStack {
                        Text("4")
                        RoundedRectangle(cornerRadius: 20.0)
                            .stroke(.purple.opacity(0.9), lineWidth: 3)
                            .matchedGeometryEffect(id: move ? "card_basic4" : "", in: readingCard04, isSource: true)
                            .frame(width: width, height: height)
                        Text("Future / surprise")
                    }
                    .foregroundColor(.purple)
                }
            }
            Spacer()
            
        }
        .sheet( isPresented: $showCardSheet01){
            OneCardSheetCoreDB(oneCard: shuffledDeck[0],givenText: "This card represents your \nissue, topic or quoestion. \nIt shows what's on your mind. ")
        }
        
        .sheet( isPresented: $showCardSheet02){
            OneCardSheetCoreDB(oneCard: shuffledDeck[1], givenText: "This card tells you what you should \navoid! Don't do that!")
        }
        
        .sheet( isPresented: $showCardSheet03){
            OneCardSheetCoreDB(oneCard: shuffledDeck[2], givenText: "This card tells you \nwhat you should do. \nIt shows you the direction to go.")
        }
        
        .sheet( isPresented: $showCardSheet04){
            OneCardSheetCoreDB(oneCard: shuffledDeck[3], givenText: "This card shows a possible outcome, \nif you follow the card 2 and 3. \nThe goal to achieve.")
        }
        
    }
}

#Preview {
    LittleCrossView(width: 80, height: 120)
}

