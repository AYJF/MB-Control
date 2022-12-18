//
//  Return.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 12/17/22.
//

import SwiftUI
import UIPilot

enum Factura: String, CaseIterable, Identifiable {
    case conFactura, sinFactura
    var id: Self { self }
}

enum Payment: String, CaseIterable, Identifiable {
    case parcial, total
    var id: Self { self }
}


struct Return: View {
    
    @EnvironmentObject var pilot: UIPilot<AppRoute>
    @State private var selectedFactura: Factura = .conFactura
    @State private var selection = "A"
    @State private var cliente:Int = 0
    @State private var factura: String = ""
    @State private var selectedPayment: Payment = .parcial
    @EnvironmentObject  var loginVM: LoginViewModel
    let empresa = ["A", "B", "C", "D"]
    
    @State private var cucaValue: String = "0"
    @State private var ADRValue: String = "0"
    @State private var FinValue: String = "0"
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .green
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    var body: some View {
        
        ZStack {
            Color("Background").ignoresSafeArea()
     
            VStack(alignment: .center, spacing: 20) {
                HStack {
                    Button(action: {
                        pilot.pop()

                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(.white))
                
                    }
                    Spacer()
                    Text("Retorno")
                        .font(.largeTitle.weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                
                Spacer()
                VStack {
                    Picker("Factura", selection: $selectedFactura) {
                        ForEach(Factura.allCases) { iva in
                            Text(iva.rawValue.uppercased())
                        }
                    }

                }
                .pickerStyle(.segmented)
                .padding(.bottom, 16)
    
                

                
                HStack {
                    
                    Picker("Clientes", selection: $cliente) {
                        ForEach(0 ..< (loginVM.users?.data.count ?? 0), id: \.self) {
                            Text(self.loginVM.users?.data[$0].name ?? "").tag($0)
                        }
                    }
                    .pickerStyle(.menu)
                    .foregroundColor(.white)
                    
                    Picker("Seleccione la empresa", selection: $selection) {
                                ForEach(empresa, id: \.self) {
                                    Text($0)
                                }
                    }
                    .pickerStyle(.menu)
                    .foregroundColor(.white)
                    
                    TextField("", text: $factura )
                        .customTextField(image: Image("Icon Email"))
                        .foregroundColor(.black)
                }.padding()
                
                
                TextField("", text: $factura )
                    .customTextField(image: Image("Icon Email"))
                    .foregroundColor(.black)
                
                
                VStack {
                    Picker("Payment", selection: $selectedPayment) {
                        ForEach(Payment.allCases) { pay in
                            Text(pay.rawValue.uppercased())
                        }
                    }

                }
                .pickerStyle(.segmented)
                .padding(.bottom, 16)   
            
                VStack(alignment: .leading) {
                    Text(loginVM.models?.data[0].name ?? "")
                        .customFont(.subheadline)
                        .foregroundColor(.secondary)
                    TextField("", text: $cucaValue )
                        .customTextField(image: Image("Icon Email"))
                        .foregroundColor(.black)
                }
            
                VStack(alignment: .leading) {
                    Text(loginVM.models?.data[1].name ?? "")
                        .customFont(.subheadline)
                        .foregroundColor(.secondary)
                    TextField("", text: $ADRValue )
                        .customTextField(image: Image("Icon Email"))
                        .foregroundColor(.black)
                }
             
                VStack(alignment: .leading) {
                    Text(loginVM.models?.data[2].name ?? "")
                        .customFont(.subheadline)
                        .foregroundColor(.secondary)
                    TextField("", text: $FinValue )
                        .customTextField(image: Image("Icon Email"))
                        .foregroundColor(.black)
                }
                
                
                Button("Guardar") {
                
                }
                .buttonStyle(GrowingButton())
            
              
                
            }
            .frame(height: 430)
            .background(
                Image("Spline")
                    .offset(x: 250, y: -100)
            )
            .padding(20)
       
        }
     
 
    
    }
}

struct Return_Previews: PreviewProvider {
    static var previews: some View {
        Return()
    }
}
