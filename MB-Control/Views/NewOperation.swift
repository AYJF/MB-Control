//
//  NewOperation.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 12/17/22.
//

import SwiftUI
import UIPilot

struct NewOperation: View {
    @EnvironmentObject var pilot: UIPilot<AppRoute>
    var body: some View {
        VStack {
            Text("Recent")
                .customFont(.title3)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 20) {
                ForEach(courseSections) { section in
                    HCard(section: section)
                    .onTapGesture {
                        if section.title == "Asignar Factura" {
                            pilot.push(.invoice)
                        }else if section.title == "Retorno" {
                            pilot.push(.retorno)
                        }
                    }
                    .navigationTitle("Retorno")
                }
            }
        }
        .padding(.vertical, 20)
    }
}

struct NewOperation_Previews: PreviewProvider {
    static var previews: some View {
        NewOperation()
    }
}
