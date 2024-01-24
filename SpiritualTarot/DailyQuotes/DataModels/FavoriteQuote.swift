//
//  FavoriteQuote.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import Foundation
import FirebaseFirestoreSwift

class FavoriteQuote: Codable, Identifiable {
    @DocumentID var id: String?

    var userID: String
    var q: String
    var a: String
    var isFavorite: Bool
}
