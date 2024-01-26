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
    
    init() {
        fetchQuotes()
    }
    
    // MARK: Variables
    private var listener: ListenerRegistration?

    @Published var favQuotes = [FavoriteQuote]()
    
    
    
    // MARK: Functions
    func createFavQuote(thisQuote: String, thisAuthor: String, thisFavorite: Bool) {
        guard let userId = FirebaseManager.shared.userId else { return }

        //let favQuote:  = FavoriteQuote(q: "qqq", a: "aaa", isFavorite: false)
        let favQuote2 = FavoriteQuote(userID: userId, q: thisQuote, a: thisAuthor, isFavorite: thisFavorite)
        
        do {
            try FirebaseManager.shared.database.collection("favQuotes").addDocument(from: favQuote2)
        } catch let error {
            print("Error saving the Favorite Quotes: \(error)")
        }
    }
    
    
    func fetchQuotes() {
        guard let userId = FirebaseManager.shared.userId else { return }
        
        self.listener = FirebaseManager.shared.database.collection("favQuotes").whereField("userID", isEqualTo: userId).addSnapshotListener { querySnaphot, error in
            
            if let error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = querySnaphot?.documents else {
                print("Error loading Favorite Quotes")
                return
            }
            
            self.favQuotes = documents.compactMap { queryDocumentSnapshot -> FavoriteQuote? in
                try? queryDocumentSnapshot.data(as: FavoriteQuote.self)
            }
        }
    }
    
    
    func removeListener() {
        favQuotes.removeAll()
        listener?.remove()
    }
    
    
    func deleteFavQuote(with id: String) {
        FirebaseManager.shared.database.collection("favQuotes").document(id).delete() { error in
            if let error {
                print("Error deleting Favorite Quote", error.localizedDescription)
                return
            }
            print("DELETED FavQuote with ID: \(id)")
        }
    }
    
    //Checks if a quote already is in our favorite List 'favQuotes'
    // is needed for the Likes Button (decides if heart is full(favorites) or not(not a favorite))
    func containsQuote(_ quote: String) -> Bool {
        favQuotes.contains {
            $0.q == quote
        }
    }

}
