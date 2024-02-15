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
        
        VStack {
            Picker("Arcanas", selection: $selectedTab) {
                ForEach(ArcanaTabsEnum.allCases, id: \.self) { tab in
                    Text(tab.rawValue).tag(tab)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            selectedTab.tabView()
        }
        Spacer()
        
    }
}

#Preview {
    TarotSchoolTopView()
}
