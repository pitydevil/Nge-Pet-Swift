//
//  MonitoringBody.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 12/11/22.
//

import Foundation

struct MonitoringBody : Decodable {
    let userID: Int
    let date: String
    let pets: [PetBody]
}

extension MonitoringBody {
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case date, pets
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userID   = try container.decode(Int.self, forKey: .userID)
        date = try container.decode(String.self, forKey: .date)
        pets = try container.decode([PetBody].self, forKey: .pets)
    }
}
