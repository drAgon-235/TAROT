//
//  LoveOracleView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 15.02.24.
//

import SwiftUI

struct LoveOracleView: View {
    
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

    // Variables for saving a session - in alert:
    @StateObject var savedSessionsVM = SavedSessionViewModel()
    @State private var sessionIsSaved = false
    @State var showSaveSessionAlert = false
    var listOfIDsToSave: [Int16] = []
    @State var newSessionTopic = ""
    
    
    
    
    var body: some View {

        VStack{
            HStack {
                ZStack{
                    // the magic of moving and disappearing buttons:
                    if move {
                        if sessionIsSaved {
                            Text("Session saved")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.mint)
                                .padding(40)
                        } else {
                            ActionBTN(text: "Save", action: {showSaveSessionAlert.toggle()}, action_02: {}, action_03: {})
                                .padding(40)
                        }
                    } else {
                        ActionBTN(text: "Shuffle",
                                  action: shuffleCards,
                                  action_02: {cardVM.justShuffle()}, // this action makes the Deck really shuffle each time you click the BTN
                                  // you see the result: every time another card is flipping !!! This is Perfection !!!
                                  action_03: {})
                                .padding(40)
                        // Optional Query-Text for repetition of shuffling:
                        if readingBtnIsVisible {
                            Text("..again..?")
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
                    CardFrontTurn(theWidth: width, theHeight: height, myDegree: $frontDegreeReading, card: cardVM.allCards[0])
                        .matchedGeometryEffect(id: "card_basic1", in: readingCard01, isSource: false)
                    // & the corresponding [transparent] button (appears just when card is laid out):
                    TransparentCardBTN(action: toggleCard01Sheet )
                        .matchedGeometryEffect(id: "card_basic1", in: readingCard01, isSource: false)

                    
                    // Card 2 - Front & Back:
                    CardBackTurn(theWidth: width, theHeight: height, myDegree: $backDegreeReading)
                        .matchedGeometryEffect(id: "card_basic2", in: readingCard02, isSource: false)
                    CardFrontTurn(theWidth: width, theHeight: height, myDegree: $frontDegreeReading, card: cardVM.allCards[1])
                        .matchedGeometryEffect(id: "card_basic2", in: readingCard02, isSource: false)
                    // & the corresponding [transparent] button (appears just when card is laid out):
                    TransparentCardBTN(action: toggleCard02Sheet )
                        .matchedGeometryEffect(id: "card_basic2", in: readingCard02, isSource: false)
                    
                    // Card 3 - Front & Back:
                    CardBackTurn(theWidth: width, theHeight: height, myDegree: $backDegreeReading)
                        .matchedGeometryEffect(id: "card_basic3", in: readingCard03, isSource: false)
                    CardFrontTurn(theWidth: width, theHeight: height, myDegree: $frontDegreeReading, card: cardVM.allCards[2])
                        .matchedGeometryEffect(id: "card_basic3", in: readingCard03, isSource: false)
                    // & the corresponding [transparent] button (appears just when card is laid out):
                    TransparentCardBTN(action: toggleCard03Sheet )
                        .matchedGeometryEffect(id: "card_basic3", in: readingCard03, isSource: false)
                    
                    // Card 4 - Front & Back:
                    CardBackTurn(theWidth: width, theHeight: height, myDegree: $backDegreeReading)
                        .matchedGeometryEffect(id: "card_basic4", in: readingCard04, isSource: false)
                    CardFrontTurn(theWidth: width, theHeight: height, myDegree: $frontDegreeReading, card: cardVM.allCards[3])
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
                    CardFrontTurn(theWidth: width, theHeight: height, myDegree: $frontDegree_A, card: cardVM.allCards[13])

                    
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
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(.green.opacity(0.9), lineWidth: 3)
                            .matchedGeometryEffect(id:  move ? "card_basic3" : "", in: readingCard03, isSource: true)
                            .frame(width: width, height: height)
                        Text("You")
                    }
                    .foregroundColor(.green)

                    
                }
                HStack(spacing: 30) {
                    VStack {
                        Text("1")
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(.blue.opacity(0.9), lineWidth: 3)
                            .matchedGeometryEffect(id: move ? "card_basic1" : "", in: readingCard01, isSource: true)
                            .frame(width: width, height: height)
                            .padding(.horizontal, 40)
                        Text("Relationship")
                    }
                    .foregroundColor(.blue)

                    
                    VStack {
                        Text("2")
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(.red.opacity(0.9), lineWidth: 3)
                            .matchedGeometryEffect(id: move ? "card_basic2" : "", in: readingCard02, isSource: true)
                            .frame(width: width, height: height)
                            .padding(.horizontal, 40)
                        Text("The other one")
                    }
                    .foregroundColor(.red)

                }
                HStack {
                    VStack {
                        Text("4")
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(.purple.opacity(0.9), lineWidth: 3)
                            .matchedGeometryEffect(id: move ? "card_basic4" : "", in: readingCard04, isSource: true)
                            .frame(width: width, height: height)
                        Text("What to do")
                    }
                    .foregroundColor(.purple)
                }
            }
            Spacer()
            
        }
        .sheet( isPresented: $showCardSheet01){
            CardSheetExplanation(oneCard: cardVM.allCards[0], givenText: "The Significator:\nThis card represents the \nrelationship, topic or question.")
        }
        
        .sheet( isPresented: $showCardSheet02){
            CardSheetExplanation(oneCard: cardVM.allCards[1], givenText: "This card shows the other person.\nHer/his attitude, expectations, \nHis/her perspective on you.")
        }
        
        .sheet( isPresented: $showCardSheet03){
            CardSheetExplanation(oneCard: cardVM.allCards[2], givenText: "This card represents your inner world. Hopes, anxieties, wishes, motivations. ")
        }
        
        .sheet( isPresented: $showCardSheet04){
            CardSheetExplanation(oneCard: cardVM.allCards[3], givenText: "This card is your Oracle! \n It can be a proposal for an action  \nor attitude.")
        }
        
        // saving the Session:
        .alert("Save the session? \n \(savedSessionsVM.getCurrentDate())", isPresented: $showSaveSessionAlert) {
            // Textfield for topic:
            TextField("Topic", text: $newSessionTopic)
            
            Button("Cancel", role: .cancel) {}
            Button("Save") {
                // creating new SavedSession in FirestoreDB with our cards in the right order (thx to List[]):
                // the current date is set automatically in the savedSessionsVM
                savedSessionsVM.createSavedSession(thisReading: AllPathsEnum.loveOracle.name, thisTopic: newSessionTopic, thisCardIdList: [ cardVM.allCards[0].id - 1, cardVM.allCards[1].id - 1, cardVM.allCards[2].id - 1, cardVM.allCards[3].id - 1 ])
                // setting the "Save"-button as inactive:
                sessionIsSaved = true
            }
        }
    }
}

#Preview {
    LoveOracleView(width: 80, height: 120)
}
