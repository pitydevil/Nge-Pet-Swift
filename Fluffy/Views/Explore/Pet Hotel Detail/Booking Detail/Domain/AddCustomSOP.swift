//
//  AddCustomSOP.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 10/11/22.
//

import Foundation

// MARK: - CustomSop
struct AddCustomSOP: Decodable {
    let customSopName: String
}

extension AddCustomSOP{
    enum CodingKeys: String, CodingKey {
        case customSopName = "custom_sop_name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        customSopName   = try container.decode(String.self, forKey: .customSopName)
    }
}
