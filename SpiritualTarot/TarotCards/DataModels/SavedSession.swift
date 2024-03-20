//
//  SavedSession.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 16.02.24.
//


import Foundation
import FirebaseFirestoreSwift

// For the Firestore Favorites DB:
struct SavedSession: Codable, Identifiable {
    @DocumentID var id: String?

    var userID: String
    var reading: String
    var topic: String
    var date: String
    var cardsIdList: [Int16]
}
