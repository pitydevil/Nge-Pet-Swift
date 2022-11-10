//
//  PetHotelsDetail.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 10/11/22.
//

import Foundation

struct PetHotelsDetail: Decodable {
    let petHotelID: Int
    let petHotelName, petHotelDescription, petHotelLongitude, petHotelLatitude: String
    let petHotelAddress, petHotelKelurahan, petHotelKecamatan, petHotelKota: String
    let petHotelProvinsi, petHotelPos: String
    let petHotelStartPrice : String
    let supportedPet: [SupportedPet]
    let petHotelImage: [PetHotelImage]
    let fasilitas: [Fasilitas]
    let sopGeneral: [SopGeneral]
    let asuransi: [AsuransiDetail]
    let cancelSOP: [CancelSOP]
}

extension PetHotelsDetail {
    enum CodingKeys: String, CodingKey {
        case petHotelID = "pet_hotel_id"
        case petHotelName = "pet_hotel_name"
        case petHotelDescription = "pet_hotel_description"
        case petHotelLongitude = "pet_hotel_longitude"
        case petHotelLatitude = "pet_hotel_latitude"
        case petHotelAddress = "pet_hotel_address"
        case petHotelKelurahan = "pet_hotel_kelurahan"
        case petHotelKecamatan = "pet_hotel_kecamatan"
        case petHotelKota = "pet_hotel_kota"
        case petHotelProvinsi = "pet_hotel_provinsi"
        case petHotelPos = "pet_hotel_pos"
        case supportedPet = "supported_pet"
        case petHotelImage = "pet_hotel_image"
        case petHotelStartPrice = "pet_hotel_start_price"
        case fasilitas
        case sopGeneral = "sop_general"
        case asuransi
        case cancelSOP = "cancel_s_o_p"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        petHotelID   = try container.decode(Int.self, forKey: .petHotelID)
        petHotelName = try container.decode(String.self, forKey: .petHotelName)
        petHotelDescription = try container.decode(String.self, forKey: .petHotelDescription)
        petHotelLongitude = try container.decode(String.self, forKey: .petHotelLongitude)
        petHotelLatitude = try container.decode(String.self, forKey: .petHotelLatitude)
        petHotelAddress = try container.decode(String.self, forKey: .petHotelAddress)
        petHotelKelurahan = try container.decode(String.self, forKey: .petHotelKelurahan)
        petHotelKecamatan = try container.decode(String.self, forKey: .petHotelKecamatan)
        petHotelKota = try container.decode(String.self, forKey: .petHotelKota)
        petHotelProvinsi = try container.decode(String.self, forKey: .petHotelProvinsi)
        petHotelPos  = try container.decode(String.self, forKey: .petHotelPos)
        petHotelStartPrice  = try container.decode(String.self, forKey: .petHotelStartPrice)
        supportedPet = try container.decode([SupportedPet].self, forKey: .supportedPet)
        fasilitas  = try container.decode([Fasilitas].self, forKey: .fasilitas)
        sopGeneral =  try container.decode([SopGeneral].self, forKey: .sopGeneral)
        asuransi   = try container.decode([AsuransiDetail].self, forKey: .asuransi)
        cancelSOP  = try container.decode([CancelSOP].self, forKey: .cancelSOP)
        petHotelImage = try container.decode([PetHotelImage].self, forKey: .petHotelImage)
    }
}
