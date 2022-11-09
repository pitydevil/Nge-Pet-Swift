//
//  PetHotels.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 09/11/22.
//

import Foundation

// MARK: - Datum
struct PetHotels: Decodable {
    let petHotelID: Int
    let petHotelName, petHotelLongitude, petHotelLatitude, petHotelDistance: String
    let petHotelImage: String
    let petHotelSupportedPet: [PetHotelSupportedPet]
    let petHotelStartPrice: String
}

extension PetHotels {
    enum CodingKeys: String, CodingKey {
        case petHotelID = "pet_hotel_id"
        case petHotelName = "pet_hotel_name"
        case petHotelLongitude = "pet_hotel_longitude"
        case petHotelLatitude = "pet_hotel_latitude"
        case petHotelDistance = "pet_hotel_distance"
        case petHotelImage = "pet_hotel_image"
        case petHotelSupportedPet = "pet_hotel_supported_pet"
        case petHotelStartPrice = "pet_hotel_start_price"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        petHotelID   = try container.decode(Int.self, forKey: .petHotelID)
        petHotelName = try container.decode(String.self, forKey: .petHotelName)
        petHotelLongitude = try container.decode(String.self, forKey: .petHotelLongitude)
        petHotelLatitude = try container.decode(String.self, forKey: .petHotelLatitude)
        petHotelDistance  = try container.decode(String.self, forKey: .petHotelDistance)
        petHotelImage = try container.decode(String.self, forKey: .petHotelImage)
        petHotelSupportedPet  = try container.decode([PetHotelSupportedPet].self, forKey: .petHotelSupportedPet)
        petHotelStartPrice = try container.decode(String.self, forKey: .petHotelStartPrice)
    }
}
