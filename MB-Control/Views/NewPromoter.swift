//
//  NewPromoter.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 11/7/22.
//

import SwiftUI

struct NewPromoter: View {
    
    @State private var username: String = ""
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Name")
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                TextField("", text: $username )
                    .customTextField(image: Image("Topic 1"))
            }
            
        }
    }
}

struct NewPromoter_Previews: PreviewProvider {
    static var previews: some View {
        NewPromoter()
    }
}
