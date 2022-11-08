//
//  CancelSop.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 08/11/22.
//

import Foundation

struct CancelSOP: Codable {
    let cancelSopsID: Int
    let cancelSopsDescription, petHotelID: String
}

extension CancelSOP {
    
    enum CodingKeys: String, CodingKey {
        case cancelSopsID = "cancel_sops_id"
        case cancelSopsDescription = "cancel_sops_description"
        case petHotelID = "pet_hotel_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cancelSopsID   = try container.decode(Int.self, forKey: .cancelSopsID)
        cancelSopsDescription = try container.decode(String.self, forKey: .cancelSopsDescription)
        petHotelID = try container.decode(String.self, forKey: .petHotelID)
    }
}
