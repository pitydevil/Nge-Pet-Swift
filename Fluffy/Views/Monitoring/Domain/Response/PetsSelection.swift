//
//  PetsSelection.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 12/11/22.
//

import Foundation

struct PetsSelection : Encodable, Decodable{
    var petID : UUID?
    var petData : String?
    var petAge : Int?
    var petBreed : String?
    var petName : String?
    var petSize : String?
    var petType : String?
    var petGender : String?
    var dateCreated : Date?
    var isChecked   : Bool?
}
