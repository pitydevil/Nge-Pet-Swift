//
//  Pet.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 04/11/22.
//

import Foundation

struct Pets : Encodable, Decodable{
    var petID : UUID?
    var petData : String?
    var petAge : Int16?
    var petBreed : String?
    var petName : String?
    var petSize : String?
    var petType : String?
    var petGender : String?
    var dateCreated : Date?
}
