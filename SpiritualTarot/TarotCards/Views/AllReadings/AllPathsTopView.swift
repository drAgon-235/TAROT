//
//  AllPathsView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 14.02.24.
//

import SwiftUI

struct AllPathsTopView: View {
    
    var body: some View {
        ZStack {
            Image("aaareadings01").resizable().scaledToFill().opacity(0.3)

            VStack {
                NavigationLink(destination: SimplePathView(width: 80, height: 120)) {
                    ReadingDefaultBTN(text: AllPathsEnum.simplePath.name)
                }
                
                NavigationLink(destination: LittleCrossView(width: 80, height: 120)) {
                    ReadingDefaultBTN(text: AllPathsEnum.littleCross.name)
                }
                
                NavigationLink(destination: GreatPathView(width: 60, height: 90)) {
                    ReadingDefaultBTN(text: AllPathsEnum.greatPath.name)
                }
                
                NavigationLink(destination: LoveOracleView(width: 80, height: 120)) {
                    ReadingDefaultBTN(text: AllPathsEnum.loveOracle.name)
                }
            }
        }
            

            
            //.navigationBarTitle(Text("Tarot Cards"))
        
    }
}

#Preview {
    AllPathsTopView()
}
