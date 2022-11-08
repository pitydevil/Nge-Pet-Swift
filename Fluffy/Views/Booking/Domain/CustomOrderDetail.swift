//
//  CustomOrderDetail.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 08/11/22.
//

import Foundation

struct CustomOrderDetail : Decodable{
    
    let orderDetailID: Int
    let petName, petType, petSize, orderDetailPrice: String
    let packageID, orderID, createdAt, updatedAt: String
    let package: Package
    let customSOP: [CustomSOP]
}

extension CustomOrderDetail {
    enum CodingKeys: String, CodingKey {
           case orderDetailID = "order_detail_id"
           case petName = "pet_name"
           case petType = "pet_type"
           case petSize = "pet_size"
           case orderDetailPrice = "order_detail_price"
           case packageID = "package_id"
           case orderID = "order_id"
           case createdAt = "created_at"
           case updatedAt = "updated_at"
           case package
           case customSOP = "custom_s_o_p"
       }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orderDetailID = try container.decode(Int.self, forKey: .orderDetailID)
        petName = try container.decode(String.self, forKey: .petName)
        petType = try container.decode(String.self, forKey: .petType)
        petSize = try container.decode(String.self, forKey: .petSize)
        orderDetailPrice = try container.decode(String.self, forKey: .orderDetailPrice)
        packageID = try container.decode(String.self, forKey: .packageID)
        orderID   = try container.decode(String.self, forKey: .orderID)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
        customSOP = try container.decode([CustomSOP].self, forKey: .customSOP)
        package   = try container.decode(Package.self, forKey: .package)
    }
}
