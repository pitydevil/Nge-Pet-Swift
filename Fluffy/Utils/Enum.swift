//
//  Enum.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 23/10/22.
//

import Foundation

enum HTTPMethod: String {
    case get  = "GET"
    case post = "POST"
    case put  = "PUT"
}

enum ApplicationEndpoint {
    case getEtalaseById(id : String)
    case getAllEtalase
    case postConsultation(etalaseID: String, companyName : String, url1 : String, url2: String, shortDescription: String, problemDescription : String, marketingBudget : Double, userID : String)
    case getConsultation(userID : String)
    case getConsultationAgency(etalaseID : String)
    case rejectEtalaseConsultation(consultationID : String, feedback : String )
    case acceptEtalaseConsultation(consultationID : String)
    case rejectUserConsultation(consultationID : String)
    case getOfferByEtalaseId(etalaseID : String)
    case getTaskByOfferID(offerID : String)
    case getOfferByUserId(userID: String)
   // case createTask(offerID : String)
}
