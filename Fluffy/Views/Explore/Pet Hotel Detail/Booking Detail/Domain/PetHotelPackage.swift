//
//  PetHotelPackage.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 13/11/22.
//

import Foundation

struct PetHotelPackage: Decodable {
    let packageID: Int
    let packageName, packagePrice, petHotelID, supportedPetID: String
    let packageDetail: [PackageDetail]
}

extension PetHotelPackage {
    enum CodingKeys: String, CodingKey {
        case packageID = "package_id"
        case packageName = "package_name"
        case packagePrice = "package_price"
        case petHotelID = "pet_hotel_id"
        case supportedPetID = "supported_pet_id"
        case packageDetail = "package_detail"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        packageID = try container.decode(Int.self, forKey: .packageID)
        packageName = try container.decode(String.self, forKey: .packageName)
        packagePrice = try container.decode(String.self, forKey: .packagePrice)
        petHotelID = try container.decode(String.self, forKey: .petHotelID)
        supportedPetID = try container.decode(String.self, forKey: .supportedPetID)
        packageDetail = try container.decode([PackageDetail].self, forKey: .packageDetail)
    }
}
