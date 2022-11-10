//
//  SOPGeneral.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 10/11/22.
//

import Foundation

struct SopGeneral: Decodable {
    let sopGeneralsID: Int
    let sopGeneralsDescription, petHotelID: String
}

extension SopGeneral {
    
    enum CodingKeys: String, CodingKey {
        case sopGeneralsID = "sop_generals_id"
        case sopGeneralsDescription = "sop_generals_description"
        case petHotelID = "pet_hotel_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sopGeneralsID   = try container.decode(Int.self, forKey: .sopGeneralsID)
        sopGeneralsDescription = try container.decode(String.self, forKey: .sopGeneralsDescription)
        petHotelID = try container.decode(String.self, forKey: .petHotelID)
    }
}
