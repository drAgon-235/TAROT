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
                ReadingDefaultBTN(text: "The Simple Path")
            }
            
            NavigationLink(destination: LittleCrossView(width: 80, height: 120)) {
                ReadingDefaultBTN(text: "The Little Cross")
            }
            
            NavigationLink(destination: GreatPathView(width: 60, height: 90)) {
                ReadingDefaultBTN(text: "The Great Path")
            }
            
            NavigationLink(destination: LoveOracleView(width: 80, height: 120)) {
                ReadingDefaultBTN(text: "Love Oracle")
            }
            
            //.navigationBarTitle(Text("Tarot Cards"))
            
            
            
        

        
    }
}

#Preview {
    AllPathsTopView()
}
