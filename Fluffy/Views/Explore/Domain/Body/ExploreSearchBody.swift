//
//  ExploreSearchBody.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 14/11/22.
//

import Foundation

struct ExploreSearchBody : Decodable {
    let longitude, latitude : Double
    let checkInDate, checkOutDate : String
    let pets: [PetBody]
}
