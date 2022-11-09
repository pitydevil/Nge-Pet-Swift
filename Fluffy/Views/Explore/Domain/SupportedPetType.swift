//
//  SupportedPetType.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 09/11/22.
//

import Foundation

// MARK: - SupportedPetType
struct SupportedPetType: Codable {
    let supportedPetTypeID: Int
    let supportedPetID, supportedPetTypeShortSize: String
}

extension SupportedPetType{
    enum CodingKeys: String, CodingKey {
        case supportedPetTypeID = "supported_pet_type_id"
        case supportedPetID = "supported_pet_id"
        case supportedPetTypeShortSize = "supported_pet_type_short_size"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        supportedPetTypeID   = try container.decode(Int.self, forKey: .supportedPetTypeID)
        supportedPetID = try container.decode(String.self, forKey: .supportedPetID)
        supportedPetTypeShortSize = try container.decode(String.self, forKey: .supportedPetTypeShortSize)
    }
}
