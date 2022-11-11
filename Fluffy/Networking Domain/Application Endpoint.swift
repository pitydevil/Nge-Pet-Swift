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
        case .getMonitoringByDate:
            return "/public/api/monitoring/get-monitoring-data-by-date"
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
        case .getMonitoringByDate:
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
        case .getMonitoringByDate(let userID, let date):
            return [
                "user_id"   : userID,
                "date"      : date
            ]
//        case .postConsultation(let etalaseID, let companyName, let url1, let url2, let shortDescription, let problemDescription, let marketingBudget, let userID):
//            return [
//                "etalaseID" : etalaseID,
//                "companyName" : companyName,
//                "url1" : url1,
//                "url2" : url2,
//                "shortDescription" : shortDescription,
//                "problemDescription" : problemDescription,
//                "marketingBudget" : marketingBudget,
//                "userID": userID
//            ]
//        case .getConsultation(let userID):
//            return [
//                "userID" : userID
//            ]
//        case .rejectUserConsultation(let consultationID):
//            return [
//                "consultationID" : consultationID
//            ]
//        case .getConsultationAgency(let etalaseID):
//            return [
//                "etalaseID" : etalaseID
//            ]
//        case .rejectEtalaseConsultation(let consultationID, let feedback):
//            return [
//                "consultationID" : consultationID,
//                "feedback" : feedback
//            ]
//        case .acceptEtalaseConsultation(let consultationID):
//            return [
//                "consultationID" : consultationID
//            ]
//        case .getOfferByEtalaseId(let etalaseID):
//            return [
//                "etalaseID" : etalaseID
//            ]
//        case .getTaskByOfferID(let offerID):
//            return [
//                "offerID" : offerID
//            ]
//        case .getOfferByUserId(let userID):
//            return [
//                "userID" : userID
//            ]
        default:
            return nil
        }
    }
}
