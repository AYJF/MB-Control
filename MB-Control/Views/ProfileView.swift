//
//  ProfileView.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 11/4/22.
//

import SwiftUI
import RiveRuntime



struct ProfileView: View {
    @State private var showSettingsView = false
    @State private var iapButtonTitle = "Purchase Lifetime Pro Plan"
    @State private var showActionAlert = false
    @State private var alertTitle = "Purchase Successful!"
    @State private var alertMessage = "You are now a Pro member and can access all courses"
    @State var updater: Bool = false
    
    let ratingAnimation = RiveViewModel(fileName: "rating_animation", stateMachineName: "State Machine 1")

//    @EnvironmentObject var authentication: Authentication

    @EnvironmentObject  var loginVM: LoginViewModel
    @State private var showLoader = false
    
    @State var rating: Double = 5

    var body: some View {
   
        ZStack {
//            Image("background-1")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .ignoresSafeArea()
            Color("Background").ignoresSafeArea()
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 16) {
                  
                            ZStack {
                                Circle()
                                    .foregroundColor(Color("pink-gradient-1"))
                                    .frame(width: 66, height: 66, alignment: .center)
                                Image(systemName: "person.fill")
                                    .font(.system(size: 24, weight: .medium, design: .rounded))
                            }
                            .frame(width: 66, height: 66, alignment: .center)
                      
                        VStack(alignment: .leading) {
                            Text(loginVM.credentials.email.split(separator: "@")[0] )
                                .foregroundColor(.white)
                                .font(.title3)
                                .bold()
                            Text("Nombre Promotor")
                                .foregroundColor(.white).opacity(0.7)
                                .font(.footnote)
                        }
                        Spacer()
                        Button {
                            showSettingsView.toggle()
                            print("Token :",loginVM.credentials.token)
        
                        } label: {
                            TextFieldIcon(iconName: "gearshape.fill", currentlyEditing: .constant(true))
                        }
                    }
                    
     
                    ratingAnimation.view()
                        .frame(height: 50)
                        .onAppear {
                            ratingAnimation.setInput("rating", value: rating)
                        }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.white.opacity(0.1))
                    Text( "INFORMACION")
                        .foregroundColor(.white)
                        .font(.title2)
                        .bold()
         
                    HStack(spacing: 16) {
                        
                            Image(systemName: "link")
                                .foregroundColor(Color.white.opacity(0.7))
                                .font(.system(size: 17, weight: .semibold))
                            Text("Piso")
                                .foregroundColor(Color.white.opacity(0.7))
                                .font(.footnote)
                        
                    }
                    
                    
                   HStack(spacing: 16) {
                       
                           Image(systemName: "percent")
                               .foregroundColor(Color.white.opacity(0.7))
                               .font(.system(size: 17, weight: .semibold))
                           Text("Porcentaje")
                               .foregroundColor(Color.white.opacity(0.7))
                               .font(.footnote)
                       
                   }
                    
                    HStack(spacing: 16) {
                        
                            Image(systemName: "percent")
                                .foregroundColor(Color.white.opacity(0.7))
                                .font(.system(size: 17, weight: .semibold))
                            Text("Modelo de Negocios")
                                .foregroundColor(Color.white.opacity(0.7))
                                .font(.footnote)
                        
                    }
                    
                    HStack(spacing: 16) {
                        
                            Image(systemName: "person")
                                .foregroundColor(Color.white.opacity(0.7))
                                .font(.system(size: 17, weight: .semibold))
                            Text("Informacion de conctacto")
                                .foregroundColor(Color.white.opacity(0.7))
                                .font(.footnote)
                        
                    }
                }
                .padding(16)
                GradientButton(buttonText: "Editar" )
                    .frame(width: 235)
                .alert(isPresented: $showActionAlert, content: {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .cancel())
                })
                
                .padding(.horizontal, 16)
                
                Button {
                    showLoader = true
           
                } label: {
                    GradientText(text: "No, didn't help")
                        .font(Font.footnote.bold())
                }
                    .padding(.bottom)
                    
            }
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white.opacity(0.2))
                    .background(Color("secondaryBackground").opacity(0.5))
                    .background(VisualEffectBlur(blurStyle: .dark))
                    .shadow(color: Color("shadowColor").opacity(0.5), radius: 60, x: 0, y: 30)
           
                  
                    
            )
            .cornerRadius(30)
            .padding(.horizontal)
            .frame(height: 430)
            .background(
                Image("Blob 1")
                    .offset(x: 250, y: -100)
                
            )
          
            
            VStack{
                Spacer()
                Button {
             
                } label: {
                    Image(systemName: "arrow.turn.up.forward.iphone.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 0, z: 1))
                        .background(
                            Circle()
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                .frame(width: 40, height: 40, alignment: .center)
                                .overlay(
                                    VisualEffectBlur(blurStyle: .dark)
                                        .cornerRadius(20)
                                        .frame(width: 40, height: 40, alignment: .center)
                                )
                        )

                }

            }
            .padding(.bottom, 60)
            
            if showLoader {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
        .colorScheme(updater ? .dark : .dark)
        .onAppear() {
      



        }
    }
    
    func dateFormatter(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    

}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
