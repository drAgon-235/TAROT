//
//  ArcanaTabsEnum.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 15.02.24.
//

import Foundation
import SwiftUI

enum ArcanaTabsEnum: String, CaseIterable {
    case major = "Major"
    case cups = "Cups"
    case swords = "Swords"
    case wands = "Wands"
    case coins = "Coins"
    
    @ViewBuilder
    func tabView() -> some View {
        switch self {
        case .major : MajorView()
        case .cups : CupsView()
        case .wands : WandsView()
        case .coins : CoinsView()
        case .swords : SwordsView()
        }
    }
    
}
