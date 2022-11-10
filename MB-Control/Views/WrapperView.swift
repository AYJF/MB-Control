//
//  WrapperView.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 11/5/22.
//

import SwiftUI

struct WrapperView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    @EnvironmentObject var model: Model

    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            switch selectedTab {
            case .home:
                HomeView()
            case .explore:
                ProfileView()
            case .notifications:
                ProfileView()
            case .profile:
                ProfileView()
            }
            
            TabBar()
                .offset(y: model.showDetail ? 200 : 0)
        
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 44)
        }
    }
}


struct WrapperView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WrapperView()
            WrapperView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(Model())
    }
}
