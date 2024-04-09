//
//  AnimTabBar.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 22.02.24.
//  Inspired by: https://www.youtube.com/watch?v=Zm44vlIZcbE&list=LL&index=9


import SwiftUI

struct AnimTabBar: View {
    
    @State var currentTab: TabEnum = .tabTarot
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    // Matched Geometry effect:
    @Namespace var animation
    @State var currentXValue: CGFloat = 0
    
    // Bonus : Splash Animation - Start values:
    @State private var imageScale: CGSize = .init(width: 1.4, height: 1.4)
    @State private var readyToLoad: Bool = false
    @StateObject var cardVM = CardViewModelCoreDB()
    
    var body: some View {
        ZStack {
            // Bonus : Animated Card as Splash Start screen after Login:
            ZStack {
                Image("m10")
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 10)
                    .scaleEffect(self.imageScale)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.5)) {
                            self.imageScale = CGSize(width: 0.0, height: 0.0)
                            
                            // deadline should be the same as duration of animation !!! :
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                                withAnimation {
                                    self.readyToLoad.toggle()
                                }
                            })
                        }
                    }
            }
            
            // After Start Splash Animation:
            if readyToLoad {
                VStack {
                    TabView(selection: $currentTab) {
                        
                        TarotTopView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .tag(TabEnum.tabTarot)
                        
                        QuoteTopView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                }
            }
        }
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

