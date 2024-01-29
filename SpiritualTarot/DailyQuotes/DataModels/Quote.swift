//
//  Quote.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import Foundation
import FirebaseFirestoreSwift

// class for API call - (it work as struct as well)
struct Quote: Codable {
    var q: String
    var a: String
}
