//
//  SuiteEnum.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 14.02.24.
//

import Foundation

enum SuiteEnum {
    case sword, cup, coin, wand, major_Arcana
    
    var name: String {
        switch self {
        case .sword: return "Swords"
        case .cup: return "Cups"
        case .coin: return "Coins"
        case .wand: return "Wands"
        case .major_Arcana: return "Major Arcana"
        }
        
    }
}
