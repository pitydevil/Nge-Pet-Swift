//
//  SupportedPet.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 10/11/22.
//

import Foundation

struct SupportedPet: Decodable {
    let supportedPetID: Int
    let supportedPetName, petHotelID: String
    let supportedPetTypes: [SupportedPetTypeDetail]
}

extension SupportedPet {
    enum CodingKeys: String, CodingKey {
        case supportedPetID = "supported_pet_id"
        case supportedPetName = "supported_pet_name"
        case petHotelID = "pet_hotel_id"
        case supportedPetTypes = "supported_pet_types"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        petHotelID   = try container.decode(String.self, forKey: .petHotelID)
        supportedPetName   = try container.decode(String.self, forKey: .supportedPetName)
        supportedPetID   = try container.decode(Int.self, forKey: .supportedPetID)
        supportedPetTypes   = try container.decode([SupportedPetTypeDetail].self, forKey: .supportedPetTypes)
    }
}
