//
//  PackageDetail.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 13/11/22.
//

import Foundation

struct PackageDetail: Codable {
    let packageDetailID: Int
    let packageDetailName, packageID: String
}

extension PackageDetail {
    enum CodingKeys: String, CodingKey {
        case packageDetailID = "package_detail_id"
        case packageDetailName = "package_detail_name"
        case packageID = "package_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        packageDetailID   = try container.decode(Int.self, forKey: .packageDetailID)
        packageDetailName   = try container.decode(String.self, forKey: .packageDetailName)
        packageID   = try container.decode(String.self, forKey: .packageID)
    }
}
