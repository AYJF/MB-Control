//
//  MB_ControlApp.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 11/1/22.
//

import SwiftUI

@main
struct MB_ControlApp: App {
    
    @StateObject var authentication = Authentication()
    var body: some Scene {
        WindowGroup {
            
            if authentication.isValidated {
                WrapperView()
                    .preferredColorScheme(.dark)
                    .environmentObject(authentication)
                    .environmentObject(Model())
            }else {
                OnboardingView(show: .constant(true))
                    .environmentObject(authentication)
            }
         

        }
    }
}
