//
//  SignInView.swift
//  RiveApp
//
//  Created by Alvaro Jimenez on 11/3/22.
//

import SwiftUI
import RiveRuntime

struct SignInView: View {
    @State var isLoading = false
    @Binding var show: Bool
    let confetti = RiveViewModel(fileName: "confetti", stateMachineName: "State Machine 1")
    let check = RiveViewModel(fileName: "check", stateMachineName: "State Machine 1")
    
    
    @StateObject private var loginVM = LoginViewModel()
    @EnvironmentObject var authentication: Authentication
    @AppStorage("selectedAuth") var selectedAuth: Auth = .signIn
    @State private var showHomeScreen = false
    
    func logIn() async  {
        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
             check.triggerInput("Check")
        }
         await   loginVM.login { success in
             
             if success {
                 DispatchQueue.main.asyncAfter(deadline: .now() ) {
                     confetti.triggerInput("Trigger explosion")
                     withAnimation {
                         isLoading = false
                     }
     
     
                 }
             }else {
                 DispatchQueue.main.asyncAfter(deadline: .now() ) {
                    check.triggerInput("Error")
                }
                 DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                   isLoading = false
               }
             }
                     
             
             DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                 authentication.updateValidation(success: success)
             }
             
            
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Text("Sign in")
                    .customFont(.largeTitle)
                Text("Acceda a una aplicacion customizada enfocada a mejorar la experiencia del usuario con cada click")
                    .foregroundColor(.secondary)
                VStack(alignment: .leading) {
                    Text("Email")
                        .customFont(.subheadline)
                        .foregroundColor(.secondary)
                    TextField("", text: $loginVM.credentials.email)
                        .customTextField(image: Image("Icon Email"))
                }
                VStack(alignment: .leading) {
                    Text("Password")
                        .customFont(.subheadline)
                        .foregroundColor(.secondary)
                    SecureField("", text: $loginVM.credentials.password)
                        .customTextField(image: Image("Icon Lock"))
                }
                
                Button  {
                    Task {
                        await logIn()
                      }
                    
                } label: {
                    HStack {
                        Image(systemName: "arrow.right")
                        Text("Sign in")
                            .customFont(.headline)
                    }
                    .largeButton()
                }
                
                
                HStack {
                    Rectangle().frame(height: 1).opacity(0.1)
                    Text("OR").customFont(.subheadline2).foregroundColor(.black.opacity(0.3))
                    Rectangle().frame(height: 1).opacity(0.1)
                }
                
                Text("Sign up with Email, Apple, Google")
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack {
                    Image("Logo Email")
                        .onTapGesture {
                            
                            print("Aqui")
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                selectedAuth = .signUp
                                
                            }
                        }
                    Spacer()
                    Image("Logo Apple")
                    Spacer()
                    Image("Logo Google")
                }
                
                
                   
     
            }
            .padding(30)
            .background(.regularMaterial)
            .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
            .shadow(color: Color("Shadow").opacity(0.3), radius: 30, x: 0, y: 30)
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.linearGradient(colors: [.white.opacity(0.8), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing))
            )
            .overlay(
                ZStack {
                    if isLoading {
                        check.view()
                            .frame(width: 100, height: 100)
                            .allowsHitTesting(false)
                    }
                    confetti.view()
                        .scaleEffect(3)
                        .allowsHitTesting(false)
                }
            )
        .padding()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(show: .constant(true))
    }
}
