//
//  NavigatorView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import SwiftUI

struct NavigatorView: View {
    var body: some View {
        TabView {
            ForEach(Tab.allCases) { tab in
                tab.view
                    .tabItem {
                        Label(tab.title, systemImage: tab.icon)
                    }
                    .tag(tab)
            }
        }
    }
}

#Preview {
    NavigatorView()
}
