//
//  OrderAdd.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 16/11/22.
//

import Foundation

struct OrderAdd : Decodable {
    var orderDateCheckIn, orderDateCheckOu : String
    var orderTotalPrice, userID, petHotelId : Int
    var orderDetails : [OrderDetailBodyFinal]
}
