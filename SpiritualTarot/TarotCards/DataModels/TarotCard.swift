//
//  TarotCard.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 14.02.24.
//

import Foundation
import SwiftUI

struct TarotCard :  Identifiable {
    var id: Int16
    var name: String
    var value: String
    var image: String
    var suite: SuiteEnum
    var description: String
    var keywords: String
    var fortuneTelling: String
    var meaning: String
    var qTA: String
    var position: Int
}
