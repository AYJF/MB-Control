//
//  WrapperView.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 11/5/22.
//

import SwiftUI
import UIPilot

// Define routes of the app
enum AppRoute: String, Equatable {
    case Home
    case Profile  // Typesafe parameters
    case Explore
    case Notifications

}


struct WrapperView: View {
//    @AppStorage("selectedTab") var selectedTab: AppRoute = .Home

    
    
    @StateObject var pilot = UIPilot(initial: AppRoute.Home)

    
    var body: some View {

            UIPilotHost(pilot)  { route in
               switch route {
                   case .Home: PilotStack {
                       HomeView()
                   }
                   case .Explore: PilotStack {
                       HomeView()
                   }
                   case .Notifications: PilotStack {
                       HomeView()
                   }
                   case .Profile: PilotStack {
                       ProfileView()
                   }
               }
            }.ignoresSafeArea()

    }
}



struct PilotStack<Content: View>: View {
    @EnvironmentObject var model: Model
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        ZStack(alignment: .bottom)  {
            self.content
            
            TabBar()
                .offset(y: model.showDetail ? 200 : 0)
            
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
