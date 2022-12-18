//
//  Course.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 12/17/22.
//

import SwiftUI

struct Course: Identifiable {
    let id = UUID()
    var title: String
    var subtitle: String
    var text: String
    var image: String
    var background: String
    var logo: String
}

var featuredCourses = [
    Course(title: "Nuevo Cliente", subtitle: "Agregue un nuevo cliente", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", image: "Illustration 5", background: "Background 5", logo: "Logo 2"),
    Course(title: "Nuevo Promotor", subtitle: "Agregue un nuevo promotor", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", image: "Illustration 3", background: "Background 4", logo: "Logo 4"),
    Course(title: "Nueva Operacion", subtitle: "Agregue una nueva operacion", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua", image: "Illustration 1", background: "Background 1", logo: "Logo 1"),
    Course(title: "Nuevo Reporte", subtitle: "Genere un nuevo reporte", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", image: "Illustration 2", background: "Background 2", logo: "Logo 3"),
]

var courses = [
    Course(title: "Agosto", subtitle: "20 sections - 3 hours", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", image: "Illustration 9", background: "Background 5", logo: "Logo 2"),
    Course(title: "Septiembre", subtitle: "20 sections - 3 hours", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", image: "Illustration 2", background: "Background 3", logo: "Logo 3"),
    Course(title: "Sindicatos", subtitle: "20 sections - 3 hours", text: "DLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", image: "Illustration 3", background: "Background 4", logo: "Logo 4"),
//    Course(title: "Flutter for designers", subtitle: "20 sections - 3 hours", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", image: "Illustration 1", background: "Background 1", logo: "Logo 1"),
]


