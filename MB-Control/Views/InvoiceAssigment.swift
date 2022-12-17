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
                
                
                Spacer()
 
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
