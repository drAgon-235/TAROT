//
//  SavedSessionListView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 16.02.24.
//

import SwiftUI

struct ArchivedSessionsListView: View {
    
    @ObservedObject private var savedSessionVM = SavedSessionViewModel()
    
    // Global variables for each card:
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack {
            Color.orange.opacity(0.3)
                .ignoresSafeArea() // has to be exactly here, not at the end of the Stack

            VStack {
                Text("Saved Sessions")
                    .foregroundColor(.orange)
                    .font(.title)
                
                List(savedSessionVM.savedSessions ) { session in
                    NavigationLink {
                        // ge the fitting View for the archived Session, by Enum:
                        if session.reading == AllPathsEnum.simplePath.name {
                            SimplePathArchiveView(width: width, height: height, cardIdList: session.cardsIdList, pathName: session.reading, date: session.date, topic: session.topic)
                            
                        } else if  session.reading == AllPathsEnum.littleCross.name {
                            LittleCrossArchiveView(width: width, height: height, cardIdList: session.cardsIdList, pathName: session.reading, date: session.date, topic: session.topic)
                            
                        } else if session.reading == AllPathsEnum.loveOracle.name {
                            LoveOracleArchiveView(width: width, height: height, cardIdList: session.cardsIdList, pathName: session.reading, date: session.date, topic: session.topic)
                            
                        } else if session.reading == AllPathsEnum.greatPath.name {
                            // exceptionally smaller cards for the big set:
                            GreatPathArchiveView(width: 60 , height: 90, cardIdList: session.cardsIdList, pathName: session.reading, date: session.date, topic: session.topic)
                        }
                    } label: {
                        ArchivedSessionView(date: session.date, myTopic: session.topic, pathName: session.reading)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            // deleting the Item from FirestoreDB:
                            savedSessionVM.deleteSession(with: session.id!)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    .background(Color.orange.blur(radius: 25).opacity(0.5))
                }

            }

            
        }

    }
}

#Preview {
    ArchivedSessionsListView(width: 80, height: 120)
}
