//
//  Application Endpoint.swift
//  Toko Marketer
//
//  Created by Mikhael Adiputra on 15/10/22.
//

import Foundation

extension ApplicationEndpoint: Endpoint {
    var host: String {
        "www.fluffy.umkmbedigital.com"
    }

    var path: String {
        switch self {
        case .getOrderList:
            return "/public/api/reservation/order/list"
        case .getDetailOrderID:
            return "/public/api/reservation/order/detail"
        case .getNearest:
            return "/public/api/explore/get-nearest-pet-hotel"
        case .postOrder:
            return "/public/api/reservation/order/add"
        case .getPetHotelDetail:
            return "/public/api/reservation/pet_hotel/detail"
        case .getListMonitoring:
            return "/public/api/monitoring/get-monitoring-data"
        case .getSearchListPetHotel:
            return "/public/api/explore/search-pet-hotel"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getOrderList:
            return .post
        case .getDetailOrderID:
            return .post
        case .getNearest:
            return .post
        case .postOrder:
            return .post
        case .getPetHotelDetail:
            return .post
        case .getListMonitoring:
            return .post
        case .getSearchListPetHotel:
            return .post
        }
    }

    var body: [String : Any]? {
        switch self {
        case .getOrderList(let orderStatus):
            return [
                "order_status" : orderStatus
            ]
        case .getDetailOrderID(let orderID):
            return [
                "order_id" : orderID
            ]
        case .getNearest(let longitude, let latitude):
            return [
                "longitude" : longitude,
                "latitude"  : latitude
            ]
        case .getPetHotelDetail(let petHotelID):
            return [
                "pet_hotel_id" : petHotelID
            ]
        case .getListMonitoring(let monitoringBody):
            let pets = monitoringBody.pets.map { obj -> [String: Any] in
                return [
                    "pet_name" : obj.petName,
                    "pet_type" : obj.petType,
                    "pet_size" : obj.petSize
                ]
            }
            return [
                "user_id"   : monitoringBody.userID,
                "date"      : monitoringBody.date,
                "pets"      : pets
            ]
        case .getSearchListPetHotel(let exploreSearchBody):
            let pets = exploreSearchBody.pets.map { obj -> [String: Any] in
                return [
                    "pet_name" : obj.petName,
                    "pet_type" : obj.petType,
                    "pet_size" : obj.petSize
                ]
            }
            return [
                "latitude"       : exploreSearchBody.latitude,
                "longitude"      : exploreSearchBody.longitude,
                "check_in_date"  : exploreSearchBody.checkInDate,
                "check_out_date" : exploreSearchBody.checkOutDate,
                "pets" : pets
            ]
        default:
            return nil
        }
    }
}
