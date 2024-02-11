//
//  Quote.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import Foundation
import FirebaseFirestoreSwift
import SwiftData

// for API-Requests AND SwiftData !!!
@Model
class Quote: Codable {
    var q: String
    var a: String
    
    enum CodingKeys: String, CodingKey {
        case q
        case a
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.q = try container.decode(String.self, forKey: .q)
        self.a = try container.decode(String.self, forKey: .a)
    }
    
    func encode(to encoder: Encoder) throws {
        // to do or not to do ...
    }
}




/*
// class for API call - (it work as struct as well)
 // without SwiftData
struct Quote: Codable {
    var q: String
    var a: String
}
*/
