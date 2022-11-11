//
//  OrderResponse.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 11/11/22.
//

import Foundation

struct OrderResponse: Decodable{
    let status:Int
    let error: String?
    let data: String?
}
