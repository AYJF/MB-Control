//
//  PromoModel.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 11/16/22.
//

import Foundation


struct ModelData:Decodable {
   var id:String = ""
   var name:String = ""
}

struct Models: Decodable {
    let data:[ModelData]
    
}

struct PromoOptions: Decodable {
    let data: [PromoData]
    
}

struct PromoData:Decodable {
    var id:String = ""
    var name:String = ""

}


struct UserModel: Decodable {
    let data:[UserData]
}


struct UserData: Decodable {
    var id:String = ""
    var name:String = ""
    var userName:String = ""
//    var rfc:String = ""
    var promoterId:String = ""
    var promoterName:String = ""
}
