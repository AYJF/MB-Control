//
//  ContentView.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 11/1/22.
//

//https://www.youtube.com/watch?v=ASnDMEFmty0

import SwiftUI



enum FocusableField: Hashable {
    case email, password
}

struct ContentView: View {
    
    @State var animate: Bool = false
    @StateObject private var model = LoginModel()
    @FocusState private var focus : FocusableField?
    let secondaryAccentColor = Color(.systemYellow)
    
    var body: some View {
        GroupBox(content: {
         
                VStack(alignment: .leading, spacing: 5 ) {
           
                    
                    Text("user name or email:").fontWeight(.thin)
                    TextField("Email", text: $model.email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(24)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .submitLabel(.next)
                        .focused($focus, equals: .email)
                        .onSubmit {
                            focus = .password
                        }.padding(.bottom, 20)
                    
                    Text("password:").fontWeight(.thin)
                    VStackLayout(alignment: .trailing) {
                        PasswordField(text: $model.password, title: "Password")
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(24)
                            .focused($focus, equals: .password)
                            .submitLabel(.go)
                            .onSubmit {
                                Task {
                                    do {
                                        try await self.model.login()
                                    }catch{
                                        print("Error", error)
                                    }
                                }
                        }
                        
                        NavigationLink(destination: ForgotPassword(), label: {
                            Text("forgot password?")
                                .foregroundColor(.purple)
                                .fontWeight(.light)
                                .font(.system(size: 13))
                        })
                        
                      
                    }.padding(.bottom, 40)
                   
                    Button(action: {
                        Task {
                            do {
                                try await self.model.login()
                                print(self.model.user?.roles ?? "")
                                print(self.model.user?.token ?? "")
                                
                            }catch{
                                print("Error", error)
                            }
                        }
                        
                        }, label: {
                            Text("LOG IN")
                                .foregroundColor(.white)
                                .font(.headline)
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(animate ? secondaryAccentColor : Color.accentColor)
                                .cornerRadius(30)
                        }) .padding(.horizontal, animate ? 30 : 50)
                        .shadow(
                            color: animate ? secondaryAccentColor.opacity(0.7) : Color.accentColor.opacity(0.7),
                            radius: animate ? 30 : 10,
                            x: 0,
                            y: animate ? 50 : 30)
                        .scaleEffect(animate ? 1.1 : 1.0)
                        .offset(y: animate ? -7 : 0)
                    
              
       
                               
                 
                }
                .padding().onAppear(perform: addAnimation)
        }, label: {
            Label(title: {
                Text("Hi, \nWelcome back.")
                    .foregroundColor(.purple)
                    .fontWeight(.light)
                    .font(.system(size: 28))
            }, icon: {
                
            })
        } ).padding().textFieldStyle(.plain)
    }


    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}


class LoginModel: ObservableObject{
  
    @Published var email = ""
    @Published var password = ""
    @Published var user:User?
    
    
//   @ObservedObject var  serviceApi = ServiceApi()
    func login()  async throws {
//       try await  serviceApi.login(username: email, password: password)
//        self.user = serviceApi.user
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice(PreviewDevice(rawValue: "iPhone 14"))
    }
}
