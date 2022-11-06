//
//  PasswordField.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 11/2/22.
//

import SwiftUI

struct PasswordField: View {
    @State private var passwordHidden: Bool =  true
    @Binding var text: String
    let title: String
    var body: some View {
        ZStack(alignment: .trailing){
            if passwordHidden {
                SecureField(title, text: $text)
            }else {
                TextField(title, text: $text).disableAutocorrection(true)
            }
            
            Button(action: {
                passwordHidden.toggle()
            }, label: {
                Image(systemName: passwordHidden ? "eye.slash":"eye")
            }
            ).foregroundColor(.primary)
            
        }.frame(height: 18)
    }
}



