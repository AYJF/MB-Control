//
//  NewPromoter.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 11/7/22.
//

import SwiftUI

enum Piso: String, CaseIterable, Identifiable {
    case piso, percent
    var id: Self { self }
}


struct NewPromoter: View {
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    
    @State private var value: String = "0"
    
    @State private var cucaValue: String = "0"
    @State private var ADRValue: String = "0"
    @State private var FinValue: String = "0"
    
    @State private var cucaIsPercent: Bool = false
    @State private var adrIsPercent: Bool = false
    @State private var finIsPercent: Bool = false
    
    @State private var isEmail: Bool = false
    @State private var isWhatsapp: Bool = false
    
    @State private var selectedIva: Piso = .piso
    @EnvironmentObject  var loginVM: LoginViewModel
    
    @State private var selectedADR:Int = 0

    
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .green
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    


    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Name")
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                TextField("", text: $username )
                    .customTextField(image: Image("Icon Email"))
                    .foregroundColor(.black)
           
            }
            
            VStack(alignment: .leading) {
                Text("Email")
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                TextField("", text: $email )
                    .customTextField(image: Image("Icon Email"))
                    .foregroundColor(.black)
            }
            
            VStack(alignment: .leading) {
                Text("Phone")
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                TextField("", text: $phone )
                    .customTextField(image: Image("Icon Email"))
                    .foregroundColor(.black)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(loginVM.models?.data[0].name ?? "")
                        .customFont(.subheadline)
                        .foregroundColor(.secondary)
                    TextField("", text: $cucaValue )
                        .customTextField(image: Image("Icon Email"))
                        .foregroundColor(.black)
                }
                Spacer(minLength: 80)
                Toggle("Piso/%", isOn: $cucaIsPercent)
                    .toggleStyle(.switch)
            }
            
           
            HStack {
                VStack(alignment: .leading) {
                    Text(loginVM.models?.data[1].name ?? "")
                        .customFont(.subheadline)
                        .foregroundColor(.secondary)
                    TextField("", text: $ADRValue )
                        .customTextField(image: Image("Icon Email"))
                        .foregroundColor(.black)
                }
                Spacer(minLength: 80)
                Toggle("Piso/%", isOn: $adrIsPercent)
                    .toggleStyle(.switch)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(loginVM.models?.data[2].name ?? "")
                        .customFont(.subheadline)
                        .foregroundColor(.secondary)
                    TextField("", text: $FinValue )
                        .customTextField(image: Image("Icon Email"))
                        .foregroundColor(.black)
                }
                Spacer(minLength: 80)
                Toggle("Piso/%", isOn: $finIsPercent)
                    .toggleStyle(.switch)
            }
            
            
            HStack {
                
                Toggle("email", isOn: $isEmail)
                    .toggleStyle(.switch)
                Spacer(minLength: 80)
                Toggle("Whatsapp", isOn: $isWhatsapp)
                    .toggleStyle(.switch)
            }
            

            
            
            Button("Crear") {
                
   
                let arr = [
                    ["modelId": loginVM.models?.data[0].id ?? "", "value": Int(cucaValue) ?? 0, "isPercent": cucaIsPercent],
                    ["modelId": loginVM.models?.data[1].id ?? "", "value": Int(ADRValue) ?? 0, "isPercent": adrIsPercent],
                    ["modelId": loginVM.models?.data[2].id ?? "","value": Int(FinValue) ?? 0, "isPercent": finIsPercent],
                ]
                print(arr)
                
                Task {
                    await loginVM.createPromoter(name:username, models: arr,
                                                 phone:phone, email:email ,
                                                 contactByEmail: true ,
                                                 contactByPhone: true ){ success in

                        if success {
                            print("todo esta ok")
                        }
                 

                    }
                }
            }
            .buttonStyle(GrowingButton())
            
        }
    }
}

struct NewPromoter_Previews: PreviewProvider {
    static var previews: some View {
        NewPromoter()
    }
}
