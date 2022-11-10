//
//  ReportView.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 11/8/22.
//

import SwiftUI


enum Period: String, CaseIterable, Identifiable {
    case mes, tiempo
    var id: Self { self }
}


struct ReportView: View {
    
    @State private var selectedPeriod: Period = .mes
    @State private var date = Date()
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .green
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    var body: some View {
        VStack(spacing: 16){
            
            VStack {
                Picker("Period", selection: $selectedPeriod) {
                    ForEach(Period.allCases) { period in
                        Text(period.rawValue.uppercased())
                    }
                }

            }
            .pickerStyle(.segmented)
            
            DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
            
            Button("Generar Reporte") {
                        print("Button pressed!")
                    }
            .buttonStyle(GrowingButton())
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
