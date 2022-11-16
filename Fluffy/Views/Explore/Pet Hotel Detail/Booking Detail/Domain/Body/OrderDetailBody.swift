//
//  OrderDetailBody.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 15/11/22.
//

import Foundation

struct OrderDetailBody : Decodable {
    var petName, petType, petSize : String
    var packageID, orderDetailPrice : Int
    var isExpanded : Bool
    var customSOP : [CustomSopBody]
}

struct OrderDetailBodyFinal : Decodable {
    var petName, petType, petSize : String
    var packageID : Int
    var customSOP : [CustomSopBody]
}
