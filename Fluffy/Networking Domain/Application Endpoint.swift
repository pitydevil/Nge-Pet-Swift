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
    //www.fluffy.umkmbedigital.com/public
    var path: String {
        switch self {
        case .getOrderList:
            return "/public/api/reservation/order/list"
//            return "/get-all-etalase"
//        case .getEtalaseById:
//            return "/get-etalase-by-id"
//        case .postConsultation:
//            return "/post-consultation"
//        case .getConsultation:
//            return "/get-consultation-by-user-id"
//        case .rejectUserConsultation:
//            return "/reject-consultation-by-customer"
//        case .rejectEtalaseConsultation:
//            return "/reject-consultation-by-agency"
//        case .acceptEtalaseConsultation:
//            return "/accept-consultation-by-agency"
//        case .getConsultationAgency:
//            return "/get-consultation-by-etalase-id"
//        case .getOfferByEtalaseId:
//            return "/get-offer-by-etalase-id"
//        case .getTaskByOfferID:
//            return "/get-task-by-offer-id"
//        case .getOfferByUserId:
//            return "/get-offer-by-user-id"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getOrderList:
            return .post
//        case .getEtalaseById:
//            return .post
//        case .postConsultation:
//            return .post
//        case .getConsultation:
//            return .post
//        case .rejectUserConsultation:
//            return .put
//        case .getConsultationAgency:
//            return .post
//        case .rejectEtalaseConsultation:
//            return .put
//        case .acceptEtalaseConsultation:
//            return .put
//        case .getOfferByEtalaseId:
//            return .post
//        case .getTaskByOfferID:
//            return .post
//        case .getOfferByUserId:
//            return .post
        }
    }

    // disesuaikan dengan body yang harus di post ke endpoint.
    var body: [String : Any]? {
        switch self {
        case .getOrderList(let orderStatus):
            return [
                "order_status": orderStatus
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
