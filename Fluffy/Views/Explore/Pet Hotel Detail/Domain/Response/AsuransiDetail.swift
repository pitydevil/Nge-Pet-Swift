//
//  AsuransiDetail.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 10/11/22.
//

import Foundation

struct AsuransiDetail : Decodable{
    let asuransiID: Int
    let asuransiDescription, petHotelID: String
}

extension AsuransiDetail {
    enum CodingKeys: String, CodingKey {
        case asuransiID = "asuransi_id"
        case asuransiDescription = "asuransi_description"
        case petHotelID = "pet_hotel_id"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        asuransiID   = try container.decode(Int.self, forKey: .asuransiID)
        asuransiDescription   = try container.decode(String.self, forKey: .asuransiDescription)
        petHotelID   = try container.decode(String.self, forKey: .petHotelID)
    }
}
