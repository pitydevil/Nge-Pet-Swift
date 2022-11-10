//
//  AddOrder.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 10/11/22.
//

import Foundation

// MARK: - AddOrder
struct AddOrder: Decodable {
    let orderDateCheckin, orderDateCheckout: String
    let orderTotalPrice, userID, petHotelID: Int
    let orderDetails: [AddOrderDetail]
}

extension AddOrder{
    enum CodingKeys: String, CodingKey {
        case orderDateCheckin = "order_date_checkin"
        case orderDateCheckout = "order_date_checkout"
        case orderTotalPrice = "order_total_price"
        case userID = "user_id"
        case petHotelID = "pet_hotel_id"
        case orderDetails = "order_details"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orderDateCheckin   = try container.decode(String.self, forKey: .orderDateCheckin)
        orderDateCheckout = try container.decode(String.self, forKey: .orderDateCheckout)
        orderTotalPrice = try container.decode(Int.self, forKey: .orderTotalPrice)
        userID = try container.decode(Int.self, forKey: .userID)
        petHotelID  = try container.decode(Int.self, forKey: .petHotelID)
        orderDetails  = try container.decode([AddOrderDetail].self, forKey: .orderDetails)
    }
}
