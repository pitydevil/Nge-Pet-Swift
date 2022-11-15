//
//  Order.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 08/11/22.
//

import Foundation

struct Order : Decodable{
    let orderId : Int
    let orderCode, orderDateCheckIn, orderDateCheckOut, orderStatus, petHotelName : String
    let orderDetail : [OrderDetail]
}

extension Order {
    enum CodingKeys: String, CodingKey {
        case orderId      = "order_id"
        case orderCode    = "order_code"
        case orderDateCheckIn  = "order_date_checkin"
        case orderDateCheckOut = "order_date_checkout"
        case orderStatus  = "order_status"
        case petHotelName = "pet_hotel_name"
        case orderDetail  = "order_detail"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orderId   = try container.decode(Int.self, forKey: .orderId)
        orderCode = try container.decode(String.self, forKey: .orderCode)
        orderDateCheckIn = try container.decode(String.self, forKey: .orderDateCheckIn)
        orderDateCheckOut = try container.decode(String.self, forKey: .orderDateCheckOut)
        orderStatus  = try container.decode(String.self, forKey: .orderStatus)
        petHotelName = try container.decode(String.self, forKey: .petHotelName)
        orderDetail  = try container.decode([OrderDetail].self, forKey: .orderDetail)
    }
}

