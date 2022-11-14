//
//  Fasilitas.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 10/11/22.
//

import Foundation

struct Fasilitas : Decodable{
    let fasilitasID: Int
    let fasilitasName: String
    let fasilitasIconURL: String
    let fasilitasStatus, petHotelID: String
}

extension Fasilitas {
    enum CodingKeys: String, CodingKey {
        case fasilitasID = "fasilitas_id"
        case fasilitasName = "fasilitas_name"
        case fasilitasIconURL = "fasilitas_icon_url"
        case fasilitasStatus = "fasilitas_status"
        case petHotelID = "pet_hotel_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fasilitasID   = try container.decode(Int.self, forKey: .fasilitasID)
        fasilitasName = try container.decode(String.self, forKey: .fasilitasName)
        fasilitasIconURL = try container.decode(String.self, forKey: .fasilitasIconURL)
        fasilitasStatus = try container.decode(String.self, forKey: .fasilitasStatus)
        petHotelID = try container.decode(String.self, forKey: .petHotelID)
    }
}
