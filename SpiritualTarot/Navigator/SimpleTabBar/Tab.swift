//
//  Tab.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import Foundation
import SwiftUI


enum Tab: String, Identifiable, CaseIterable {
    case tarot, quotes
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .tarot: return "Tarot"
        case .quotes: return "Quotes"
        }
    }
    
    var icon: String {
        switch self {
        case .tarot: return "doc.text.image"
        case .quotes: return "quote.bubble"
        }
    }
    
    var view: AnyView {
        switch self {
        case .tarot: return AnyView(TarotTopView())
        case .quotes: return AnyView(QuoteTopView())
        }
    }
    
    
}
