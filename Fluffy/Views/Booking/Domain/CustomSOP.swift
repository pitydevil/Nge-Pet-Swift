//
//  CustomSOP.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 08/11/22.
//

import Foundation

struct CustomSOP: Codable {
    let customSopID: Int
    let customSopName, orderDetailID, monitoringID: String
}
extension CustomSOP {
    enum CodingKeys: String, CodingKey {
        case customSopID = "custom_sop_id"
        case customSopName = "custom_sop_name"
        case orderDetailID = "order_detail_id"
        case monitoringID = "monitoring_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        customSopID = try container.decode(Int.self, forKey: .customSopID)
        customSopName = try container.decode(String.self, forKey: .customSopName)
        orderDetailID = try container.decode(String.self, forKey: .orderDetailID)
        monitoringID  = try container.decode(String.self, forKey: .monitoringID)
    }
}
