//
//  PetHotelImage.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 08/11/22.
//

import Foundation

struct PetHotelImage : Decodable {
    let petHotelImageID : Int
    let petHotelImageURL, petHotelID : String
}

extension PetHotelImage {
    enum CodingKeys: String, CodingKey {
        case petHotelID       = "pet_hotel_id"
        case petHotelImageURL = "pet_hotel_image_url"
        case petHotelImageID  = "pet_hotel_image_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        petHotelImageID  = try container.decode(Int.self, forKey: .petHotelImageID)
        petHotelImageURL = try container.decode(String.self, forKey: .petHotelImageURL)
        petHotelID       = try container.decode(String.self, forKey: .petHotelID)
    }
}
