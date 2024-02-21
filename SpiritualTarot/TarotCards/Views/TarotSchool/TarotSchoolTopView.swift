//
//  TatorSchoolTop.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 15.02.24.
//

import SwiftUI

struct TarotSchoolTopView: View {
    
    @State private var selectedTab: ArcanaTabsEnum = .major
    
    var body: some View {
        ZStack {
            //Image("aaastars02").resizable().scaledToFill().opacity(0.8)
            Color.mint.opacity(0.2)
                .ignoresSafeArea() // has to be exactly here, not at the end of the Stack

            VStack {
                Text("Tarot School")
                    .bold()
                    .font(.title)
                    .foregroundColor(.mint)
                Text("The 5 Arcanas")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.orange)
                
                Picker("Arcanas", selection: $selectedTab) {
                    ForEach(ArcanaTabsEnum.allCases, id: \.self) { tab in
                        Text(tab.rawValue).tag(tab)
                    }
                    
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 10)
                
                selectedTab.tabView()
            }
        }
        Spacer()
        
    }
}

#Preview {
    TarotSchoolTopView()
}
