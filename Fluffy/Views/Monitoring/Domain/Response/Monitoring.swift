//
//  Monitoring.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 11/11/22.
//

import Foundation

struct Monitoring: Decodable {
    let monitoringID: Int
    let monitoringActivity: String
    let customSops: [CustomSOP]
    let orderDetailID, timeUpload, petHotelName, petName: String
    let notification: Bool
    let monitoringImage: [MonitoringImage]
}

extension Monitoring {
    enum CodingKeys: String, CodingKey {
        case monitoringID = "monitoring_id"
        case monitoringActivity = "monitoring_activity"
        case customSops = "custom_sops"
        case orderDetailID = "order_detail_id"
        case timeUpload = "time_upload"
        case petHotelName = "pet_hotel_name"
        case petName = "pet_name"
        case notification
        case monitoringImage = "monitoring_image"
    }
    
    init(from decoder: Decoder) throws {
        let container     = try decoder.container(keyedBy: CodingKeys.self)
        monitoringID      = try container.decode(Int.self, forKey: .monitoringID)
        monitoringActivity = try container.decode(String.self, forKey: .monitoringActivity)
        customSops        = try container.decode([CustomSOP].self, forKey: .customSops)
        orderDetailID     = try container.decode(String.self, forKey: .orderDetailID)
        timeUpload        = try container.decode(String.self, forKey: .timeUpload)
        petHotelName      = try container.decode(String.self, forKey: .petHotelName)
        petName           = try container.decode(String.self, forKey: .petName)
        notification = try container.decode(Bool.self, forKey: .notification)
        monitoringImage   = try container.decode([MonitoringImage].self, forKey: .monitoringImage)
    }
}
