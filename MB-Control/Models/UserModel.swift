//
//  UserModel.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 11/2/22.
//

import Foundation


struct User:Decodable {
    var email:String = ""
    var token: String = ""
    var roles:Array<String> = []
}
