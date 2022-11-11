//
//  MonitoringImage.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 11/11/22.
//

import Foundation

struct MonitoringImage: Codable {
    let monitoringImageID: Int
    let monitoringImageURL: String
    let monitoringID: String
}

extension MonitoringImage {
    enum CodingKeys: String, CodingKey {
        case monitoringImageID = "monitoring_image_id"
        case monitoringImageURL = "monitoring_image_url"
        case monitoringID = "monitoring_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        monitoringImageID   = try container.decode(Int.self, forKey: .monitoringImageID)
        monitoringImageURL   = try container.decode(String.self, forKey: .monitoringImageURL)
        monitoringID   = try container.decode(String.self, forKey: .monitoringID)
    }
}
