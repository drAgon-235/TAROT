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
            Image("aaa_readingBack01").resizable().scaledToFill().opacity(0.3)
            Color.blue.opacity(0.2)
            VStack {
                NavigationLink(destination: SimplePathView(width: 80, height: 120)) {
                    ReadingDefaultBTN(text: AllPathsEnum.simplePath.name)
                }
                .shadow(radius: 10)
                
                NavigationLink(destination: LittleCrossView(width: 80, height: 120)) {
                    ReadingDefaultBTN(text: AllPathsEnum.littleCross.name)
                }
                .shadow(radius: 10)
                
                NavigationLink(destination: GreatPathView(width: 60, height: 90)) {
                    ReadingDefaultBTN(text: AllPathsEnum.greatPath.name)
                }
                .shadow(radius: 10)
                
                NavigationLink(destination: LoveOracleView(width: 80, height: 120)) {
                    ReadingDefaultBTN(text: AllPathsEnum.loveOracle.name)
                }
                .shadow(radius: 10)

            }
        }
            

            
            //.navigationBarTitle(Text("Tarot Cards"))
        
    }
}

#Preview {
    AllPathsTopView()
}
