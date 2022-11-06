//
//  UserModel.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 11/2/22.
//

import Foundation


struct User:Decodable {
    let email:String
    let token: String
    let roles:Array<String>
}
