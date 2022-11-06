//
//  GradiantText.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 11/4/22.
//

import SwiftUI

extension View {
    public func gradienteForeground(colors: [Color]) -> some  View {
        self.overlay(LinearGradient(gradient: Gradient(colors: colors),
                                    startPoint: .topLeading, endPoint: .bottomTrailing))
        .mask(self)
    }
}



struct GradientText: View {
    
    var text: String = "text"
    var body: some View {
        Text(text)
            .gradienteForeground(colors:
                                    [Color("pink-gradient-1"),
                                     Color("pink-gradient-2"),
                                    ])
    }
}


