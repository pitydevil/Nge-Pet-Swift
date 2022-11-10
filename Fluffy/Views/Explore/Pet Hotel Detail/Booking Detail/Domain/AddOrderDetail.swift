//
//  AddOrderDetail.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 10/11/22.
//

import Foundation

// MARK: - OrderDetail
struct AddOrderDetail: Decodable{
    let petName, petType, petSize: String
    let packageID: Int
    let customSops: [AddCustomSOP]
}

extension AddOrderDetail{
    enum CodingKeys: String, CodingKey {
        case petName = "pet_name"
        case petType = "pet_type"
        case petSize = "pet_size"
        case packageID = "package_id"
        case customSops = "custom_sops"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        petName   = try container.decode(String.self, forKey: .petName)
        petType = try container.decode(String.self, forKey: .petType)
        petSize = try container.decode(String.self, forKey: .petSize)
        packageID = try container.decode(Int.self, forKey: .packageID)
        customSops  = try container.decode([AddCustomSOP].self, forKey: .customSops)
    }
}
