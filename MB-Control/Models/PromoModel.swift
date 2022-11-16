//
//  PromoModel.swift
//  MB-Control
//
//  Created by Alvaro Jimenez on 11/16/22.
//

import Foundation


struct PromoOptions: Decodable {
    let data: [PromoData]
    
}

struct PromoData:Decodable {
    var id:String = ""
    var name:String = ""

}
