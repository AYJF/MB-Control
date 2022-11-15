//
//  NewClient.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 11/7/22.
//

import SwiftUI

enum Iva: String, CaseIterable, Identifiable {
    case sinIva, conIva
    var id: Self { self }
}

enum Adr: String, CaseIterable, Identifiable {
    case ADR, CUCA, Finpulso
    var id: Self { self }
}




struct NewClient: View {


    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .green
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }

    
    @State private var selectedIva: Iva = .conIva
    @State private var selectedADR: Adr = .CUCA
    @State private var username: String = ""
    
    @State private var selection = "1 1"
    
    
    let pickerValues = ["1 1", "8 2%", "99"]
    
    var body: some View {

        VStack {
            
            VStack(alignment: .leading) {
                Text("Name")
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                TextField("", text: $username )
                    .customTextField(image: Image("Topic 1"))
            }.padding(.bottom, 16)
            
            VStack(alignment: .leading) {
                Text("RFC")
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                TextField("", text: $username )
                    .customTextField(image: Image("Topic 1"))
            }
     
             

             

                Picker("ADR", selection: $selectedADR) {
                        ForEach(Adr.allCases) { adr in
                               Text(adr.rawValue)

                        }
                    }
                    .pickerStyle(.wheel)


                Picker("Menu Picker", selection: $selection) {
                    pickerContent()
                }
                .pickerStyle(.wheel)



            
            VStack {
                Picker("Iva", selection: $selectedIva) {
                    ForEach(Iva.allCases) { iva in
                        Text(iva.rawValue.uppercased())
                    }
                }

            }
            .pickerStyle(.segmented)
            .padding(.bottom, 16)
   
            
            
            VStack(alignment: .leading) {
                Text("Promotor")
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                TextField("", text: $username )
                    .customTextField(image: Image("Topic 1"))
            }
            .padding(.bottom, 16)
     
            
            Button("Guardar") {
                        print("Button pressed!")
                    }
            .buttonStyle(GrowingButton())

        }.padding(.horizontal, 22)
    }
    
    
    @ViewBuilder
    func pickerContent() -> some View {
        ForEach(pickerValues, id: \.self) {
            Text($0).font(.footnote)
               
        }
    }
}

struct NewClient_Previews: PreviewProvider {
    static var previews: some View {
        NewClient()
    }
}
