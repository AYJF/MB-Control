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
    var body: some View {

        VStack(alignment: .leading) {
            
            HStack {
                Picker("ADR", selection: $selectedADR) {
                        ForEach(Adr.allCases) { adr in

                        HStack {
                               Text(adr.rawValue)
                                   .font(.footnote)
                                   .padding()
                               Spacer()
                        }

                        }
                    }
                    .pickerStyle(.wheel)
    
                Picker("ADR", selection: $selectedADR) {
                        ForEach(Adr.allCases) { adr in

                        HStack {
                               Text(adr.rawValue)
                                   .font(.footnote)
                                   .padding()
                               Spacer()
                        }

                        }
                    }
                    .pickerStyle(.wheel)
    
            }

            
            VStack {
                Picker("Iva", selection: $selectedIva) {
                    ForEach(Iva.allCases) { iva in
                        Text(iva.rawValue.uppercased())
                    }
                }

            }
            .pickerStyle(.segmented)
   
            

        }
    }
}

struct NewClient_Previews: PreviewProvider {
    static var previews: some View {
        NewClient()
    }
}
