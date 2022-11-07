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
    @AppStorage("selectedAuth") var selectedAuth: Auth = .signIn
    var body: some Scene {
        WindowGroup {
            
            if authentication.isValidated {
                WrapperView()
                    .preferredColorScheme(.dark)
                    .environmentObject(authentication)
                    .environmentObject(Model())
            }else {
                
                
                switch selectedAuth {
                case .signIn:
                     OnboardingView(show: .constant(true))
                         .environmentObject(authentication)
                case .signUp:
                    SignUp()
                case .forgot:
                    ForgotPassword()
                }
              
            }
         

        }
    }
}
