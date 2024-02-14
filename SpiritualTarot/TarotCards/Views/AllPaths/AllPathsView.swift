//
//  AllPathsView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 14.02.24.
//

import SwiftUI

struct AllPathsView: View {
    
    
    
    var body: some View {
        NavigationStack {
            
            NavigationLink(destination: SimplePathView(width: 80, height: 120)) {
                SimplePathNavBTN()

            }
            
            NavigationLink(destination: LittleCrossView(width: 80, height: 120)) {
                LittleCrossNavBTN()
            }
            
            
            
            .navigationBarTitle(Text("Tarot Cards"))
            
            
            
        }

        
    }
}

#Preview {
    AllPathsView()
}
