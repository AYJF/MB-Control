//
//  NewClient.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 11/7/22.
//

import SwiftUI



struct NewClient: View {

    @State private var username: String = ""
    @State private var rfc: String = ""
    @State private var phone: String = ""
    
    @State private var value: String = "0"
    @State private var chosenPromoter:Int = 0
    @State private var cucaValue: String = "0"
    @State private var ADRValue: String = "0"
    @State private var FinValue: String = "0"
    
    @State private var cucaIsIva: Bool = false
    @State private var adrIsIva: Bool = false
    @State private var finIsIva: Bool = false
    
    @State private var isEmail: Bool = false
    @State private var isWhatsapp: Bool = false
    
    @State private var selectedIva: Piso = .piso
    @EnvironmentObject  var loginVM: LoginViewModel
    
    @State private var selectedADR:Int = 0
    @State private var showingAlert = false
    
    

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
                Text("RFC")
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                TextField("", text: $rfc )
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
                Toggle("Iva/SinIva", isOn: $cucaIsIva)
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
                Toggle("Iva/SinIva", isOn: $adrIsIva)
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
                Toggle("Iva/SinIva", isOn: $finIsIva)
                    .toggleStyle(.switch)
            }
            Spacer()
                
            Picker("Promoteres", selection: $chosenPromoter) {
                ForEach(0 ..< (loginVM.promoters?.data.count ?? 0), id: \.self) {
                    Text(self.loginVM.promoters?.data[$0].name ?? "").tag($0)
                }
            }
            .pickerStyle(.menu)
            .foregroundColor(.white)
    
            Spacer()
            Button("Crear") {
                let arr = [
                    ["modelId": loginVM.models?.data[0].id ?? "", "value": Int(cucaValue) ?? 0, "hasIva": cucaIsIva],
                    ["modelId": loginVM.models?.data[1].id ?? "", "value": Int(ADRValue) ?? 0, "hasIva": adrIsIva],
                    ["modelId": loginVM.models?.data[2].id ?? "","value": Int(FinValue) ?? 0, "hasIva": finIsIva],
                ]
                print(arr)
                print(self.loginVM.promoters?.data[chosenPromoter].id ?? "")
                
                Task {
                    await loginVM.createClient(name: username, models: arr, rfc: rfc, promterId: self.loginVM.promoters?.data[chosenPromoter].id ?? ""){ success in

                        if success {
                            print("todo esta ok")
                            showingAlert = true
                        }


                    }
                }
            }
            .buttonStyle(GrowingButton())
            .alert("El cliente fue insertado con exito!", isPresented: $showingAlert) {
                        Button("OK", role: .cancel) {
                }
            }
            
        }
    
       

   
    }
    
}

struct NewClient_Previews: PreviewProvider {
    static var previews: some View {
        NewClient()
    }
}
