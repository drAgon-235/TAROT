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
            LinearGradient(colors: [Color.mint.opacity(0.4), .purple.opacity(0.2), .mint.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing)

            //Color.mint.opacity(0.2)
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
                
                // Segmented Picker:
                Picker("Arcanas", selection: $selectedTab) {
                    ForEach(ArcanaTabsEnum.allCases, id: \.self) { tab in
                        Text(tab.rawValue).tag(tab)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 10)
                
                // The selected View:
                selectedTab.tabView()
            }
        }
        
    }
}

#Preview {
    TarotSchoolTopView()
}
