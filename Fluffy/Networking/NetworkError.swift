//
//  NetworkError.swift
//  Toko Marketer
//
//  Created by Mikhael Adiputra on 15/10/22.
//

import Foundation

enum NetworkError: Error {
    case invalidURLRequest
    case emptyResponse
    case badRequest
    case decoding
    case internalServerError
    case underlying(Error)
}
