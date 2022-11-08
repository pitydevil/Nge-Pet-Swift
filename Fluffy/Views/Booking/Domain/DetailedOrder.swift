//
//  DetailedOrder.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 08/11/22.
//

import Foundation

struct DetailedOrder: Decodable {
    let orderID: Int
    let orderCode, orderDateCheckin, orderDateCheckout, orderTotalPrice: String
    let orderStatus, userID, petHotelID, createdAt: String
    let updatedAt: String
    let petHotel: PetHotel
    let orderDetail: [CustomOrderDetail]
}

extension DetailedOrder {
    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case orderCode = "order_code"
        case orderDateCheckin = "order_date_checkin"
        case orderDateCheckout = "order_date_checkout"
        case orderTotalPrice = "order_total_price"
        case orderStatus = "order_status"
        case userID = "user_id"
        case petHotelID = "pet_hotel_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case petHotel = "pet_hotel"
        case orderDetail = "order_detail"
    }
   
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orderID           = try container.decode(Int.self, forKey: .orderID)
        orderCode         = try container.decode(String.self, forKey: .orderCode)
        orderDateCheckin  = try container.decode(String.self, forKey: .orderDateCheckin)
        orderDateCheckout = try container.decode(String.self, forKey: .orderDateCheckout)
        orderTotalPrice = try container.decode(String.self, forKey: .orderTotalPrice)
        orderStatus     = try container.decode(String.self, forKey: .orderStatus)
        userID          = try container.decode(String.self, forKey: .userID)
        petHotelID      = try container.decode(String.self, forKey: .petHotelID)
        createdAt       = try container.decode(String.self, forKey: .createdAt)
        updatedAt       = try container.decode(String.self, forKey: .updatedAt)
        orderDetail     = try container.decode([CustomOrderDetail].self, forKey: .orderDetail)
        petHotel        = try container.decode(PetHotel.self, forKey: .petHotel)
    }
}

