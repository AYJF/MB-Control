//
//  Authentication.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 11/6/22.
//


import SwiftUI

class Authentication: ObservableObject {
    @Published var isValidated = false
    
    
//    enum AuthenticationError: Error, LocalizedError, Identifiable {
//        case invalidCredentials
//        
//        var id: String {
//            self.localizedDescription
//        }
//        
//        var errorDescription: String? {
//            switch self {
//            case .invalidCredentials:
//                return NSLocalizedString("Either your email or password are incorrect. Please try again", comment: "")
//            }
//        }
//    }
    

    
    func updateValidation(success: Bool) {
        
        withAnimation {
            self.isValidated = success
        }
    }
}
