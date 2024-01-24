//
//  FavoriteQuote.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import Foundation
import FirebaseFirestoreSwift

// For the Firestore Favorites DB:
// this has to be a 'struct'; a 'class' wouldn't work for Firebase :
struct FavoriteQuote: Codable, Identifiable {
    @DocumentID var id: String?

    var userID: String
    var q: String
    var a: String
    var isFavorite: Bool
}
