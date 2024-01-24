//
//  FavoriteQuotesVM.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class FavoriteQuotesVM: ObservableObject {
    
    // MARK: Variables
    private var listener: ListenerRegistration?

    @Published var favQuotes = [FavoriteQuote]()
    
    // MARK: Functions
    func createFavQuote(thisQuote: String, thisAuthor: String, thisFavorite: Bool) {
        guard let userId = FirebaseManager.shared.userId else { return }

        //let favQuote:  = FavoriteQuote(q: "qqq", a: "aaa", isFavorite: false)
        //let favQuote2 = FavoriteQuote(userID: userId, q: thisQuote, a: thisAuthor, isFavorite: thisFavorite)
        
        do {
            try FirebaseManager.shared.database.collection("favQuotes").addDocument(from: favQuote2)
        } catch let error {
            print("Error saving the favQuote: \(error)")
        }
    }
    
    
    func fetchQuotes() {
        
    }
    
    
    func removeListener() {
        favQuotes.removeAll()
        listener?.remove()
    }
    
    
    func deleteFavQuote() {
        
    }
}
