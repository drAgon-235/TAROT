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
    
    // Variables for filling the cards with sense & logic:
    @StateObject var cardVM = CardViewModelCoreDB()

    // Variables for saving a session - in alert:
    @StateObject var savedSessionsVM = SavedSessionViewModel()
    @State var showSaveSessionAlert = false
    var listOfIDsToSave: [Int16] = []
    @State var newSessionTopic = ""
    @State private var sessionIsSaved = false

    
    var body: some View {
        // Outer VStack:
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
                                .padding( 40)
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
                // All the cards to be lead in the back - I love ZStacks:
                ZStack {
                    // Card 1 - Front & Back & Transparent Button:
                    CardBackTurn(theWidth: width, theHeight: height, myDegree: $backDegreeReading)
                                         .matchedGeometryEffect(id: "card_basic1", in: readingCard01, isSource: false)
                                     CardFrontTurn(theWidth: width, theHeight: height, myDegree: $frontDegreeReading, card: cardVM.allCards[0])
                                         .matchedGeometryEffect(id: "card_basic1", in: readingCard01, isSource: false)
                                     // & the corresponding [transparent] button (appears just when card is laid out):
                    TransparentCardBTN(action: {showCardSheet01.toggle()} )
                                         .matchedGeometryEffect(id: "card_basic1", in: readingCard01, isSource: false)
                                     
                                     
                                     // Card 2 - Front & Back:
                                     CardBackTurn(theWidth: width, theHeight: height, myDegree: $backDegreeReading)
                                         .matchedGeometryEffect(id: "card_basic2", in: readingCard02, isSource: false)
                                     CardFrontTurn(theWidth: width, theHeight: height, myDegree: $frontDegreeReading, card: cardVM.allCards[1])
                                         .matchedGeometryEffect(id: "card_basic2", in: readingCard02, isSource: false)
                                     // & the corresponding [transparent] button (appears just when card is laid out):
                    TransparentCardBTN(action: {showCardSheet02.toggle()} )
                                         .matchedGeometryEffect(id: "card_basic2", in: readingCard02, isSource: false)
                                     
                                     // Card 3 - Front & Back:
                                     CardBackTurn(theWidth: width, theHeight: height, myDegree: $backDegreeReading)
                                         .matchedGeometryEffect(id: "card_basic3", in: readingCard03, isSource: false)
                                     CardFrontTurn(theWidth: width, theHeight: height, myDegree: $frontDegreeReading, card: cardVM.allCards[2])
                                         .matchedGeometryEffect(id: "card_basic3", in: readingCard03, isSource: false)
                                     // & the corresponding [transparent] button (appears just when card is laid out):
                    TransparentCardBTN(action: {showCardSheet03.toggle()} )
                                         .matchedGeometryEffect(id: "card_basic3", in: readingCard03, isSource: false)
                                     
                                     // Card 4 - Front & Back:
                                     CardBackTurn(theWidth: width, theHeight: height, myDegree: $backDegreeReading)
                                         .matchedGeometryEffect(id: "card_basic4", in: readingCard04, isSource: false)
                                     CardFrontTurn(theWidth: width, theHeight: height, myDegree: $frontDegreeReading, card: cardVM.allCards[3])
                                         .matchedGeometryEffect(id: "card_basic4", in: readingCard04, isSource: false)
                                     // & the corresponding [transparent] button (appears just when card is laid out):
                    TransparentCardBTN(action: {showCardSheet04.toggle()} )
                                         .matchedGeometryEffect(id: "card_basic4", in: readingCard04, isSource: false)
                                     
                                     // Card 5 - Front & Back:
                                     CardBackTurn(theWidth: width, theHeight: height, myDegree: $backDegreeReading)
                                         .matchedGeometryEffect(id: "card_basic5", in: readingCard05, isSource: false)
                                     CardFrontTurn(theWidth: width, theHeight: height, myDegree: $frontDegreeReading, card: cardVM.allCards[4])
                                         .matchedGeometryEffect(id: "card_basic5", in: readingCard05, isSource: false)
                                     // & the corresponding [transparent] button (appears just when card is laid out):
                    TransparentCardBTN(action: {showCardSheet05.toggle()} )
                                         .matchedGeometryEffect(id: "card_basic5", in: readingCard05, isSource: false)
                                                         
                                     // Card 6 - Front & Back:
                                     CardBackTurn(theWidth: width, theHeight: height, myDegree: $backDegreeReading)
                                         .matchedGeometryEffect(id: "card_basic6", in: readingCard06, isSource: false)
                                     CardFrontTurn(theWidth: width, theHeight: height, myDegree: $frontDegreeReading, card: cardVM.allCards[5])
                                         .matchedGeometryEffect(id: "card_basic6", in: readingCard06, isSource: false)
                                     // & the corresponding [transparent] button (appears just when card is laid out):
                    TransparentCardBTN(action: {showCardSheet06.toggle()} )
                                         .matchedGeometryEffect(id: "card_basic6", in: readingCard06, isSource: false)
                                     
                                     
                                     // Card 6 - Front & Back:
                                     CardBackTurn(theWidth: width, theHeight: height, myDegree: $backDegreeReading)
                                         .matchedGeometryEffect(id: "card_basic7", in: readingCard07, isSource: false)
                                     CardFrontTurn(theWidth: width, theHeight: height, myDegree: $frontDegreeReading, card: cardVM.allCards[6])
                                         .matchedGeometryEffect(id: "card_basic7", in: readingCard07, isSource: false)
                                     // & the corresponding [transparent] button (appears just when card is laid out):
                    TransparentCardBTN(action: {showCardSheet07.toggle()} )
                                         .matchedGeometryEffect(id: "card_basic7", in: readingCard07, isSource: false)

                                  
                    // The twisting cards on top:
                    // The "fake" cards (no front-picture) on the bottom (in the background)
                    CardBackTwist(theWidth: width, theHeight: height, myDegree: $backDegree_01)
                    CardBackTwist(theWidth: width, theHeight: height, myDegree: $backDegree_02)
                    CardBackTwist(theWidth: width, theHeight: height, myDegree: $backDegree_02)
                    // The only "real" card on top, otherwise you don't really see the rotation of the "Wheel of Fortune"
                    CardBackTurn(theWidth: width, theHeight: height, myDegree: $backDegree_A)
                    CardFrontTurn(theWidth: width, theHeight: height, myDegree: $frontDegree_A, card: cardVM.allCards[11])
                }
                
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
                    //Spacer()
                    
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
                                   // .padding(.horizontal, 60)
                                Text("subjective\nemotions")
                                    .font(.footnote)
                        }
                        .padding(.horizontal, 50)
                        .foregroundColor(.blue)

                        
                        VStack{
                            Text("6")
                                RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(.red.opacity(0.9), lineWidth: 3)
                                    .matchedGeometryEffect(id: move ? "card_basic6" : "", in: readingCard06, isSource: true)
                                    .frame(width: width, height: height)
                                //    .padding(.horizontal, 60)
                                Text("subjective\nemotions")
                                        .font(.footnote)
                        }
                        .padding(.horizontal, 50)
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
                                   // .padding(.horizontal, 60)
                            Text("reality")
                                    .font(.footnote)
                            
                        }
                        .padding(.horizontal, 50)
                        .foregroundColor(.blue)

                        
                        VStack{
                            Text("5")
                            RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(.red.opacity(0.9), lineWidth: 3)
                                    .matchedGeometryEffect(id: move ? "card_basic5" : "", in: readingCard05, isSource: true)
                                    .frame(width: width, height: height)
                                    //.padding(.horizontal, 60)
                            Text("reality")
                                    .font(.footnote)
                        }
                        .padding(.horizontal, 50)
                        .foregroundColor(.red)
                    }
                    // Coorective Element:
                    RoundedRectangle(cornerRadius: 10.0)
                        .frame(height: 4)
                        .opacity(0)
                    Spacer()
                    
                    
               //    } // End of scroll view
           //     .padding(.top, 30)
                
            }
            .padding(.bottom, 50)

            .sheet( isPresented: $showCardSheet01){
                CardSheetExplanation(oneCard: cardVM.allCards[0], givenText: "This card represents the CHANCES  and GOALS at the end of your path. The possible outcome.")
            }
            
            .sheet( isPresented: $showCardSheet02){
                CardSheetExplanation(oneCard: cardVM.allCards[1], givenText: "This card represents your CONSCIOUS attitude to this issue TODAY. Rational intentions, thaughts and actions. \n(compare to card 7)")
            }
            
            .sheet( isPresented: $showCardSheet03){
                CardSheetExplanation(oneCard: cardVM.allCards[2], givenText: "This card stands for your UNCONSCIOUS realm. Your feelings, desires,estimations, (wrong) expectations! \n(compare to card 6)")
            }
            
            .sheet( isPresented: $showCardSheet04){
                CardSheetExplanation(oneCard: cardVM.allCards[3], givenText: "This card shows your REALTY NOW. That's how others see you. That's what you don't know. \n(compare to card 5)")
            }
            
            .sheet( isPresented: $showCardSheet05){
                CardSheetExplanation(oneCard: cardVM.allCards[4], givenText: "This card represents your  FUTURE REALITY. It suggests how to perform, shows what you may reveal. (compare to card 4)")
            }
            
            .sheet( isPresented: $showCardSheet06){
                CardSheetExplanation(oneCard: cardVM.allCards[5], givenText: "This card suggests a direction for your emotions. It shows for what you should open your mind and heart. (compare to card 3)")
            }
            
            .sheet( isPresented: $showCardSheet07){
                CardSheetExplanation(oneCard: cardVM.allCards[6], givenText: "This card suggests, on what you should focus your thaughts and actions in FUTURE CONSCIOUSLY.\n(compare to card 2)")
            }
            
        }
        // saving the Session:
        .alert("Save the session? \n \(savedSessionsVM.getCurrentDate())", isPresented: $showSaveSessionAlert) {
            // Textfield for topic:
            TextField("Topic", text: $newSessionTopic)
            
            Button("Cancel", role: .cancel) {}
            Button("Save") {
                // creating new SavedSession in FirestoreDB with our cards in the right order (thx to List[]):
                savedSessionsVM.createSavedSession(thisReading: AllPathsEnum.greatPath.name, thisTopic: newSessionTopic, thisCardIdList: [ cardVM.allCards[0].id - 1, cardVM.allCards[1].id - 1, cardVM.allCards[2].id - 1, cardVM.allCards[3].id - 1, cardVM.allCards[4].id - 1, cardVM.allCards[5].id - 1, cardVM.allCards[6].id - 1 ])
                // setting the "Save"-button as inactive, which triggers a new View ("Session Saved"):
                sessionIsSaved = true
            }
        }
        .background(Color.blue.opacity(0.2))
    }
        
}

#Preview {
    GreatPathView(width: 60, height: 90)
}
