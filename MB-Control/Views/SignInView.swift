//
//  SignInView.swift
//  RiveApp
//
//  Created by Alvaro Jimenez on 11/3/22.
//

import SwiftUI
import RiveRuntime


enum FocusableField: Hashable {
    case email, password
}

struct SignInView: View {
    @State var isLoading = false
    @Binding var show: Bool
    let confetti = RiveViewModel(fileName: "confetti", stateMachineName: "State Machine 1")
    let check = RiveViewModel(fileName: "check", stateMachineName: "State Machine 1")
    
    
    @EnvironmentObject  var loginVM: LoginViewModel
    @EnvironmentObject var authentication: Authentication
    @AppStorage("selectedAuth") var selectedAuth: Auth = .signIn
    @State private var showHomeScreen = false
    
    @FocusState private var focus : FocusableField?
    
    func logIn() async  {
        isLoading = true


         await   loginVM.login { success in
      
             
           
             if success {
                 DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                     try? check.triggerInput("Check")
                 }
                 DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                     try? confetti.triggerInput("Trigger explosion")
                     withAnimation {
                         isLoading = false
                     }
                 }

                 
             }else {
                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                     try? check.triggerInput("Error")
                 }
                 DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                     isLoading = false
                 }
             }
             

             
             DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                 Task {
                     await loginVM.getClients();
                     await loginVM.getModels() ;
                     await loginVM.getPromoters();
             
                 }
                 
                 authentication.updateValidation(success: success)
             }
             
            
        }
    }
    
    var body: some View {
    
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
                        .focused($focus, equals: .email)
                        .onSubmit {
                          focus = .password
                        }
                }
                VStack(alignment: .leading) {
                    Text("Password")
                        .customFont(.subheadline)
                        .foregroundColor(.secondary)
                    SecureField("", text: $loginVM.credentials.password)
                        .customTextField(image: Image("Icon Lock"))
                        .focused($focus, equals: .password)
                        .onSubmit {
                            hideKeyboard()
                            Task {
                                await logIn()                
                              }
                        }
                }
                
                Button  {
                    hideKeyboard()
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


#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(show: .constant(true))
    }
}
