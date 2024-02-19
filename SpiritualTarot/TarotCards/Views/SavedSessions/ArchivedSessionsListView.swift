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
        Text("Saved Sessions")
            .foregroundColor(.purple)
            .font(.title)
        
        List(savedSessionVM.savedSessions ) { session in
            NavigationLink {
                SimplePathArchiveView(width: width, height: height)
            } label: {
                ArchivedItemView(date: session.date, reading: session.reading)
            }
            // deleting the Item from FirestoreDB:
            .swipeActions {
                Button(role: .destructive) {
                    savedSessionVM.deleteSession(with: session.id!)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
    }
}

#Preview {
    ArchivedSessionsListView(width: 80, height: 120)
}
