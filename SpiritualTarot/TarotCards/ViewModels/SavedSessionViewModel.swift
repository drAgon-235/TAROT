//
//  SimplePathViewModel.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 16.02.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

class SavedSessionViewModel: ObservableObject {
    
    init() {
        fetchSessions()
    }
    
    // Variables
    private var listener: ListenerRegistration?

    @Published var savedSessions = [SavedSession]()
    
    
    // Functions:
    func createSavedSession(thisReading: String, thisTopic: String, thisCardIdList: [Int16]) {
        guard let thisUserId = FirebaseManager.shared.userId else { return }

        let session = SavedSession(userID: thisUserId, reading: thisReading, topic: thisTopic, date: getCurrentDate(), cardsIdList: thisCardIdList)
        
        do {
            try FirebaseManager.shared.database.collection("savedSessions").addDocument(from: session)
        } catch let error {
            print("Error saving the Reading Session: \(error)")
        }
    }
    
    
    func fetchSessions() {
        guard let userId = FirebaseManager.shared.userId else { return }

        self.listener = FirebaseManager.shared.database.collection("savedSessions").whereField("userID", isEqualTo: userId).addSnapshotListener {querySnapshot, error in
            
            if let error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("Error loading Favorite Quotes")
                return
            }
            
            self.savedSessions = documents.compactMap { queryDocumentSnapshot -> SavedSession? in
                try? queryDocumentSnapshot.data(as: SavedSession.self)
            }
            
        }
    }
    
    
    func removeListener() {
        savedSessions.removeAll()
        listener?.remove()
    }
    
    
    func deleteSession(with id: String) {
        
        FirebaseManager.shared.database.collection("savedSessions").document(id).delete() { error in
            if let error {
                print("Error deleting Favorite Quote", error.localizedDescription)
                return
            }
            print("DELETED FavQuote with ID: \(id)")
        }
    }
    
    // gives us the current date formatted to a String:
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MMM-dd" // MMM: short month name
        return formatter.string(from: Date())
    }
    
    
    
}
