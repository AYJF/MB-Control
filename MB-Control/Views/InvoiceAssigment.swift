//
//  InvoiceAssigment.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 12/17/22.
//

import SwiftUI
import UIPilot

struct InvoiceAssigment: View {
    @EnvironmentObject var pilot: UIPilot<AppRoute>
    @State private var amount:String = ""
    @State private var invoiceNumber:String = ""
    @EnvironmentObject  var loginVM: LoginViewModel
    @State private var cliente:Int = 0
    @State private var model:Int = 0
    let empresa = ["A", "B", "C", "D"]
    @State private var selection = "A"
    
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
                    Text("Facturas")
                        .font(.largeTitle.weight(.bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                Spacer(minLength: 300)
                
                HStack {
                    Picker("Clientes", selection: $cliente, content: {
                        ForEach(0..<(loginVM.users?.data.count ?? 0) , content: { index in // <2>
                            Text(loginVM.users?.data[index].name ?? "")
                                .foregroundColor(.white)
                            
                        })
                    })
                    .pickerStyle(.menu)
                    
                    Picker("Modelos", selection: $model, content: {
                        ForEach(0..<(loginVM.models?.data.count ?? 0) , content: { index in // <2>
                            Text(loginVM.models?.data[index].name ?? "")
                                .foregroundColor(.white)
                            
                        })
                    })
                    .pickerStyle(.menu)
                    
                    
                    Picker("Seleccione la empresa", selection: $selection) {
                                ForEach(empresa, id: \.self) {
                                    Text($0)
                                }
                    }
                    .pickerStyle(.menu)
                    .foregroundColor(.white)
                }
      
                
                VStack(alignment: .leading) {
                    Text("Numero de factura")
                        .customFont(.subheadline)
                        .foregroundColor(.secondary)
                    TextField("", text: $invoiceNumber )
                        .customTextField(image: Image("Icon Email"))
                        .foregroundColor(.black)
                }
                
                VStack(alignment: .leading) {
                    Text( "Monto")
                        .customFont(.subheadline)
                        .foregroundColor(.secondary)
                    TextField("", text: $amount )
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

struct InvoiceAssigment_Previews: PreviewProvider {
    static var previews: some View {
        InvoiceAssigment()
    }
}
