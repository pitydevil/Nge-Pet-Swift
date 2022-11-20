//
//  SupportedPetTypeDetail.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 10/11/22.
//

import Foundation

// MARK: - SupportedPetType
struct SupportedPetTypeDetail: Codable {
    let supportedPetTypeID: Int
    let supportedPetTypeShortSize, supportedPetTypeSize, supportedPetID, supportedPetTypeDescription: String
}

extension SupportedPetTypeDetail {
    enum CodingKeys: String, CodingKey {
        case supportedPetTypeID = "supported_pet_type_id"
        case supportedPetTypeShortSize = "supported_pet_type_short_size"
        case supportedPetTypeSize = "supported_pet_type_size"
        case supportedPetID = "supported_pet_id"
        case supportedPetTypeDescription = "supported_pet_type_description"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        supportedPetTypeID   = try container.decode(Int.self, forKey: .supportedPetTypeID)
        supportedPetID = try container.decode(String.self, forKey: .supportedPetID)
        supportedPetTypeShortSize = try container.decode(String.self, forKey: .supportedPetTypeShortSize)
        supportedPetTypeSize = try container.decode(String.self, forKey: .supportedPetTypeSize)
        supportedPetTypeDescription = try container.decode(String.self, forKey: .supportedPetTypeDescription)
    }
}
