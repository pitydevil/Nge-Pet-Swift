//
//  Package.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 08/11/22.
//

import Foundation

struct Package: Codable {
    let packageID: Int
    let packageName, packagePrice, petHotelID, supportedPetID: String

}

extension Package {
    enum CodingKeys: String, CodingKey {
        case packageID = "package_id"
        case packageName = "package_name"
        case packagePrice = "package_price"
        case petHotelID = "pet_hotel_id"
        case supportedPetID = "supported_pet_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        packageID   = try container.decode(Int.self, forKey: .packageID)
        packageName = try container.decode(String.self, forKey: .packageName)
        packagePrice = try container.decode(String.self, forKey: .packagePrice)
        petHotelID = try container.decode(String.self, forKey: .petHotelID)
        supportedPetID = try container.decode(String.self, forKey: .supportedPetID)
    }
}
