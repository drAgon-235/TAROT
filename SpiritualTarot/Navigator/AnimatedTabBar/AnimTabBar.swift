//
//  AnimTabBar.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 22.02.24.
//


// Quelle angeben

import SwiftUI

struct AnimTabBar: View {
    
    @State var currentTab: TabEnum = .tabTarot
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    // Matched Geometry effect:
    @Namespace var animation
    
    @State var currentXValue: CGFloat = 0
    
    var body: some View {
        
        TabView(selection: $currentTab) {
            
            TarotTopView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                //.background(Color(Color.mint.opacity(0.2)).ignoresSafeArea())
                .tag(TabEnum.tabTarot)
            
            QuoteTopView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
               // .background(Color(Color.purple.opacity(0.2)).ignoresSafeArea())
                .tag(TabEnum.tabQuotes)
        }
        // Curved Tab bar:
        .overlay(
            HStack(spacing: 0) {
                ForEach(TabEnum.allCases, id: \.rawValue) { thisTab in
                    tabButton(tab: thisTab)
                }
            }
                .padding(.vertical)
                .padding(.bottom, getSafeArea().bottom == 0 ? 10 : (getSafeArea().bottom - 10))
                .background(
                    MaterialEffect(style: .systemUltraThinMaterial)
                        .clipShape(BottomCurve(currentXValue: currentXValue))
                )
            
            ,alignment: .bottom
        )
        .ignoresSafeArea(.all, edges: .bottom)
        //.preferredColorScheme(.light)
        
    }
    
    
    // Tab Button:
    @ViewBuilder
    func tabButton(tab: TabEnum) -> some View {
        
        // For the XAxis Values:
        GeometryReader { proxy in
            
            Button {
                withAnimation(.spring()){
                    currentTab = tab
                    // Updatiing Value:
                    currentXValue = proxy.frame(in: .global).midX
                }
            } label: {
                // Moving Button up for current View:
                Image(systemName: tab.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.accentColor)
                    .padding(currentTab == tab ? 15 : 0)
                    .background(
                        ZStack {
                            if currentTab == tab {
                                MaterialEffect(style: .systemChromeMaterial)
                                    .clipShape(Circle())
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                    )
                    .contentShape(Rectangle())
                    .offset(y: currentTab == tab ? -50 : 0)
            }
            // Setting initial curve position:
            .onAppear {
                if tab == TabEnum.allCases.first && currentXValue == 0 {
                    currentXValue = proxy.frame(in: .global).midX
                }
            }
            
        }
        .frame(height: 10)
        // Max Size    }
    }
    
}
    
    
    #Preview {
        AnimTabBar()
    }
    
    // Getting safe area (responsive):
    extension View {
        func getSafeArea() -> UIEdgeInsets {
            guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                return .zero
            }
            guard let safeArea = screen.windows.first?.safeAreaInsets else {
                return .zero
            }
            return safeArea
        }
    }

