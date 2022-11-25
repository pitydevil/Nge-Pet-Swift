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
        case .getPetHotelPackage:
            return "/public/api/reservation/pet_hotel/package"
        case .getSearchListPetHotel:
            return "/public/api/explore/search-pet-hotel"
        case .getOrderAdd:
            return "/public/api/reservation/order/add"
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
        case .getPetHotelPackage:
            return .post
        case .getSearchListPetHotel:
            return .post
        case .getOrderAdd:
            return .post
        }
    }

    var body: [String : Any]? {
        switch self {
        case .getOrderList(let orderStatus, let userID):
            return [
                "order_status" : orderStatus,
                "user_id"      : userID
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
        case .getPetHotelPackage(let petHotelPackage):
            return [
                "pet_hotel_id"       : petHotelPackage.petHotelID,
                "supported_pet_name" : petHotelPackage.supportedPetName
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
                "pets"           : pets
            ]
        case .getOrderAdd(let order):
            let orderDetail = order.orderDetails.map { obj -> [String : Any] in
                let customSOP = obj.customSOP.map { customSop -> [String : Any] in
                    return [
                        "custom_sop_name" : customSop.customSopName
                    ]
                }
                return [
                    "pet_name": obj.petName,
                    "pet_type": obj.petType,
                    "pet_size": obj.petSize,
                    "package_id": obj.packageID,
                    "custom_sops": customSOP
                ]
            }
            return [
                "order_date_checkin": order.orderDateCheckIn,
                "order_date_checkout": order.orderDateCheckOu,
                "order_total_price": order.orderTotalPrice,
                "user_id": order.userID,
                "pet_hotel_id": order.petHotelId,
                "order_details" : orderDetail
            ]
        default:
            return nil
        }
    }
}
