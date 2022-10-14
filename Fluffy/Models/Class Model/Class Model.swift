//
//  Class Model.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 03/10/22.
//

import Foundation
import UIKit

//MARK - Carousel Image Data
struct CarouselData {
    let image: UIImage?
}

struct PetSupported{
    let petType:String
    let size:String
}

struct PetHotelList{
    let petHotelName:String
    let petHotelDistance:String
    let supportedPet:[PetSupported]
    let lowestPrice:Int
    let displayImage:String
}
