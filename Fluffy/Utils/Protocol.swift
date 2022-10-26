//
//  Protocol.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 23/10/22.
//

import Foundation

protocol NetworkServicing {
    func request<T: Decodable, E: Endpoint>(to endpoint: E, decodeTo model: T.Type) async -> Result<T, NetworkError>
}

protocol Endpoint {
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var body: [String: Any]? { get }
}