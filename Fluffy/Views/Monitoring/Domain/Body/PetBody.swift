//
//  PetBody.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 12/11/22.
//

import Foundation

struct PetBody: Codable {
    let petName, petType, petSize: String
}

extension PetBody {
    enum CodingKeys: String, CodingKey {
        case petName = "pet_name"
        case petType = "pet_type"
        case petSize = "pet_size"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        petName   = try container.decode(String.self, forKey: .petName)
        petType = try container.decode(String.self, forKey: .petType)
        petSize = try container.decode(String.self, forKey: .petSize)
    }
}
