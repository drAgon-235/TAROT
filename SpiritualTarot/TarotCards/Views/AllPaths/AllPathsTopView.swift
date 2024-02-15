//
//  AllPathsView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 14.02.24.
//

import SwiftUI

struct AllPathsTopView: View {
    
    
    
    var body: some View {
       
            
            NavigationLink(destination: SimplePathView(width: 80, height: 120)) {
                SimplePathNavBTN()

            }
            
            NavigationLink(destination: LittleCrossView(width: 80, height: 120)) {
                LittleCrossNavBTN()
            }
            
            NavigationLink(destination: GreatPathView(width: 80, height: 120)) {
                GreatPathNavBTN()
            }
            
            
            //.navigationBarTitle(Text("Tarot Cards"))
            
            
            
        

        
    }
}

#Preview {
    AllPathsTopView()
}
