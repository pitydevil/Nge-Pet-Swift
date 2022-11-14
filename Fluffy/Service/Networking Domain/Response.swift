//
//  Response.swift
//  Toko Marketer
//
//  Created by Mikhael Adiputra on 15/10/22.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    let data: T?
    let error: String?
    let status: Int?
}

struct EmptyData: Decodable {}
