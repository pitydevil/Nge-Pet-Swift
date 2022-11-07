//
//  OrderDetail.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 08/11/22.
//

import Foundation

struct OrderDetail : Decodable{
    
    let petName, petType, petSize, packageName, customSopCount : String
}

extension OrderDetail {
    enum CodingKeys: String, CodingKey {
        case petName        = "pet_name"
        case petType        = "pet_type"
        case petSize        = "pet_size"
        case packageName    = "package_name"
        case customSopCount = "custom_sops_count"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        petName = try container.decode(String.self, forKey: .petName)
        petType = try container.decode(String.self, forKey: .petType)
        petSize = try container.decode(String.self, forKey: .petSize)
        packageName  = try container.decode(String.self, forKey: .packageName)
        customSopCount = try container.decode(String.self, forKey: .customSopCount)
    }
}
