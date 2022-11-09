//
//  PetHotelSupportedPet.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 09/11/22.
//

import Foundation

// MARK: - PetHotelSupportedPet
struct PetHotelSupportedPet: Codable {
    let petHotelID, supportedPetName: String
    let supportedPetID: Int
    let supportedPetType: [SupportedPetType]

    enum CodingKeys: String, CodingKey {
        case petHotelID = "pet_hotel_id"
        case supportedPetName = "supported_pet_name"
        case supportedPetID = "supported_pet_id"
        case supportedPetType = "supported_pet_type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        supportedPetID   = try container.decode(Int.self, forKey: .supportedPetID)
        petHotelID = try container.decode(String.self, forKey: .petHotelID)
        supportedPetName = try container.decode(String.self, forKey: .supportedPetName)
        supportedPetType  = try container.decode([SupportedPetType].self, forKey: .supportedPetType)
    }
}
