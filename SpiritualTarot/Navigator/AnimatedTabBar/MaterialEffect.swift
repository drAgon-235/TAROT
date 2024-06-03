//
//  MaterialEffect.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 22.02.24.
//  Inspired by: https://www.youtube.com/watch?v=Zm44vlIZcbE&list=LL&index=9


import Foundation
import SwiftUI

struct MaterialEffect: UIViewRepresentable {
    
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}
