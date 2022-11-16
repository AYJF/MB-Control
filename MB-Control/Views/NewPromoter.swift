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
            
            VStack(alignment: .leading) {
                Text("Value")
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                TextField("", text: $value )
                    .customTextField(image: Image("Icon Email"))
                    .foregroundColor(.black)
            }
            
            
            VStack {
                Picker("Piso", selection: $selectedIva) {
                    ForEach(Piso.allCases) { piso in
                        Text(piso.rawValue.uppercased())
                    }
                }
                
            }
            .onChange(of: selectedIva){ _ in
                print(selectedIva)
            }
            .pickerStyle(.segmented)
            .padding(.bottom, 16)
            
            Picker("ADR", selection: $selectedADR) {
                ForEach(0 ..< loginVM.promoData.data.count) {
                                Text(loginVM.promoData.data[$0].name)
                            }
                }.onChange(of: selectedADR) { _ in
                    print(loginVM.promoData.data[selectedADR].name)
                }.pickerStyle(.wheel)
            
            
            Button("Guardar") {
//                print("#########################")
//                print(loginVM.promoData.data[selectedADR].id)
//                print(username)
//                print(email)
//                print(phone)
//                print(selectedIva == .piso ? true: false)
//                print("================================")
                
                let value:Double = Double(value ) ?? 0.0
                
                Task {
                    await loginVM.createPromoter(name:username, isPercent:selectedIva == .piso ? true: false,value: value,
                                                 optionId:loginVM.promoData.data[selectedADR].id,
                                                 phone:phone, email:email ,contactByEmail: true , contactByPhone: true ){ success in
                        
                        
                        print(success)
                        
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
