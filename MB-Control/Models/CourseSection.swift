//
//  CourseSection.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 12/17/22.
//

import SwiftUI

struct CourseSection: Identifiable {
    var id = UUID()
    var title: String
    var caption: String
    var color: Color
    var image: Image
}

var courseSections = [
//    CourseSection(title: "State Machine", caption: "Watch video - 15 mins", color: Color(hex: "9CC5FF"), image: Image("Topic 2")),
    CourseSection(title: "Asignar Factura", caption: "Asigne sus nuevas facturas", color: Color(hex: "6E6AE8"), image: Image("Topic 2")),
//    CourseSection(title: "Tab Bar", caption: "Watch video - 8 mins", color: Color(hex: "005FE7"), image: Image("Topic 2")),
    CourseSection(title: "Retorno", caption: "Opciones de rotorno", color: Color(hex: "BBA6FF"), image: Image("Topic 1"))
]

