//
//  GreatPathView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 15.02.24.
//

import SwiftUI

struct GreatPathView: View {

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
    @Namespace private var readingCard05
    @Namespace private var readingCard06
    @Namespace private var readingCard07

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
    @State var showCardSheet05 = false
    @State var showCardSheet06 = false
    @State var showCardSheet07 = false


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

    private func toggleCard05Sheet() {
        showCardSheet05.toggle()
    }
    
    private func toggleCard06Sheet() {
        showCardSheet06.toggle()
    }

    private func toggleCard07Sheet() {
        showCardSheet07.toggle()
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
                    
                    // Card 5 - Front & Back:
                    CardBackTurn(theWidth: width, theHeight: height, myDegree: $backDegreeReading)
                        .matchedGeometryEffect(id: "card_basic5", in: readingCard05, isSource: false)
                    CardFrontTurn(theWidth: width, theHeight: height, myDegree: $frontDegreeReading, card: shuffledDeck[4])
                        .matchedGeometryEffect(id: "card_basic5", in: readingCard05, isSource: false)
                    // & the corresponding [transparent] button (appears just when card is laid out):
                    TransparentCardBTN(action: toggleCard05Sheet )
                        .matchedGeometryEffect(id: "card_basic5", in: readingCard05, isSource: false)
                                        
                    // Card 6 - Front & Back:
                    CardBackTurn(theWidth: width, theHeight: height, myDegree: $backDegreeReading)
                        .matchedGeometryEffect(id: "card_basic6", in: readingCard06, isSource: false)
                    CardFrontTurn(theWidth: width, theHeight: height, myDegree: $frontDegreeReading, card: shuffledDeck[5])
                        .matchedGeometryEffect(id: "card_basic6", in: readingCard06, isSource: false)
                    // & the corresponding [transparent] button (appears just when card is laid out):
                    TransparentCardBTN(action: toggleCard06Sheet )
                        .matchedGeometryEffect(id: "card_basic6", in: readingCard06, isSource: false)
                    
                    
                    // Card 6 - Front & Back:
                    CardBackTurn(theWidth: width, theHeight: height, myDegree: $backDegreeReading)
                        .matchedGeometryEffect(id: "card_basic7", in: readingCard07, isSource: false)
                    CardFrontTurn(theWidth: width, theHeight: height, myDegree: $frontDegreeReading, card: shuffledDeck[6])
                        .matchedGeometryEffect(id: "card_basic7", in: readingCard07, isSource: false)
                    // & the corresponding [transparent] button (appears just when card is laid out):
                    TransparentCardBTN(action: toggleCard07Sheet )
                        .matchedGeometryEffect(id: "card_basic7", in: readingCard07, isSource: false)

                    
               
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
           // ScrollView {
               // Spacer()
                VStack {
                    Spacer()
                    
                    HStack {
                        VStack {
                            Text("PAST")
                                .foregroundColor(.blue)
                            Text("2")
                                RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(.blue.opacity(0.9), lineWidth: 3)
                                    .matchedGeometryEffect(id: move ? "card_basic2" : "", in: readingCard02, isSource: true)
                                    .frame(width: width, height: height)
                                Text(" objective\nawareness")
                                    .font(.footnote)
                        }
                        .foregroundColor(.blue)
                        
                        VStack {
                            Text("1")
                            RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(.green.opacity(0.9), lineWidth: 3)
                                    .matchedGeometryEffect(id: move ? "card_basic1" : "", in: readingCard01, isSource: true)
                                    .frame(width: width, height: height)
                                Text("Chance")
                                    .foregroundColor(.green)
                        }
                        .foregroundColor(.green)
                        // positioning this stack a little bit higher, than the other 2 cards:
                        .offset(x: 0, y: -30)
                        // and exactly central:
                        .padding(.horizontal, 30)
                        
                        
                        VStack {
                            Text("FUTURE")
                            Text("7")
                                RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(.red.opacity(0.9), lineWidth: 3)
                                    .matchedGeometryEffect(id: move ? "card_basic7" : "", in: readingCard07, isSource: true)
                                    .frame(width: width, height: height)
                                Text(" objective\nawareness")
                                    .font(.footnote)
                        }
                        .foregroundColor(.red)

                        
                    }
                    Spacer()
                    
                    HStack(spacing: 30) {
                        VStack {
                            Text("3")
                                RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(.blue.opacity(0.9), lineWidth: 3)
                                    .matchedGeometryEffect(id: move ? "card_basic3" : "", in: readingCard03, isSource: true)
                                    .frame(width: width, height: height)
                                    .padding(.horizontal, 60)
                                Text("subjective\nemotions")
                                    .font(.footnote)
                        }
                        .foregroundColor(.blue)

                        
                        VStack{
                            Text("6")
                                RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(.red.opacity(0.9), lineWidth: 3)
                                    .matchedGeometryEffect(id: move ? "card_basic6" : "", in: readingCard06, isSource: true)
                                    .frame(width: width, height: height)
                                    .padding(.horizontal, 60)
                                Text("subjective\nemotions")
                                        .font(.footnote)
                        }
                        .foregroundColor(.red)
                        
                    }
                    // space to upper HStack:
                   // .padding(.top, 10)
                    Spacer()
                    
                    HStack(spacing: 30) {
                        VStack {
                            Text("4")
                            RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(.blue.opacity(0.9), lineWidth: 3)
                                    .matchedGeometryEffect(id: move ? "card_basic4" : "", in: readingCard04, isSource: true)
                                    .frame(width: width, height: height)
                                    .padding(.horizontal, 60)
                            Text("reality")
                                    .font(.footnote)
                            
                        }
                        .foregroundColor(.blue)

                        
                        VStack{
                            Text("5")
                            RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(.red.opacity(0.9), lineWidth: 3)
                                    .matchedGeometryEffect(id: move ? "card_basic5" : "", in: readingCard05, isSource: true)
                                    .frame(width: width, height: height)
                                    .padding(.horizontal, 60)
                            Text("reality")
                                    .font(.footnote)
                        }
                        .foregroundColor(.red)

                        
                    }
                    // space to upper HStack:
                    //.padding(.top, 10)
                    Spacer()
                    
               //    } // End of scroll view
           //     .padding(.top, 30)
                
            }
            .sheet( isPresented: $showCardSheet01){
                CardSheetExplanation(oneCard: shuffledDeck[0], givenText: "This card represents the CHANCES  and GOALS at the end of your path. The possible outcome.")
            }
            
            .sheet( isPresented: $showCardSheet02){
                CardSheetExplanation(oneCard: shuffledDeck[1], givenText: "This card represents your CONSCIOUS attitude to this issue TODAY. Rational intentions, thaughts and actions. \n(compare to card 7)")
            }
            
            .sheet( isPresented: $showCardSheet03){
                CardSheetExplanation(oneCard: shuffledDeck[2], givenText: "This card stands for your UNCONSCIOUS realm. Your feelings, desires,estimations, (wrong) expectations! \n(compare to card 6)")
            }
            
            .sheet( isPresented: $showCardSheet04){
                CardSheetExplanation(oneCard: shuffledDeck[3], givenText: "This card shows your REALTY NOW. That's how others see you. That's what you don't know. \n(compare to card 5)")
            }
            
            .sheet( isPresented: $showCardSheet05){
                CardSheetExplanation(oneCard: shuffledDeck[4], givenText: "This card represents your  FUTURE REALITY. It suggests how to perform, shows what you may reveal. (compare to card 4)")
            }
            
            .sheet( isPresented: $showCardSheet06){
                CardSheetExplanation(oneCard: shuffledDeck[5], givenText: "This card suggests a direction for your emotions. It shows for what you should open your mind and heart. (compare to card 3)")
            }
            
            .sheet( isPresented: $showCardSheet07){
                CardSheetExplanation(oneCard: shuffledDeck[6], givenText: "This card suggests, on what you should focus your thaughts and actions in FUTURE CONSCIOUSLY.\n(compare to card 2)")
            }
            
            
            
            
        }
        
        //Text("Hello, World!")
    }
}

#Preview {
    GreatPathView(width: 60, height: 90)
}
