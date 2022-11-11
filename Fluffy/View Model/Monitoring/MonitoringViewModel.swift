//
//  MonitoringViewModel.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 11/11/22.
//

import Foundation
import RxSwift
import RxCocoa

class MonitoringViewModel {
    
    //MARK: OBJECT DECLARATION
    var monitoringModelArray = BehaviorRelay<[Monitoring]>(value: [])
    var dateModelObject      = BehaviorRelay<DateComponents>(value: DateComponents())
    var titleDateModelObject = BehaviorRelay<String>(value: String())
    var tanggalModelObject   = BehaviorRelay<String>(value: String())
    var tanggalEndpointModelObject   = BehaviorRelay<String>(value: String())
    private let networkService       : NetworkServicing
    
    //MARK: OBJECT OBSERVER DECLARATION
    var titleDateModelObjectObserver : Observable<String> {
        return titleDateModelObject.asObservable()
    }
    
    var tanggalModelObjectObserver : Observable<String> {
        return tanggalModelObject.asObservable()
    }
    
    var monitoringModelArrayObserver : Observable<[Monitoring]> {
        return monitoringModelArray.asObservable()
    }
    
    //MARK: - INIT OBJECT
    init(networkService: NetworkServicing = NetworkService()) {
        self.networkService = networkService
    }
    
    func configureDate() {
        let currentDate = Date()
        let currentYear = Calendar.current.component(.year, from: Date())
        let df = DateFormatter()
        var titleLbl = ""
        
        if  dateModelObject.value.year! == currentYear && dateModelObject.value.date! != currentDate{
            df.dateFormat = "dd MMM"
            titleLbl = df.string(from: (dateModelObject.value.date!))
        }else{
            df.dateFormat = "dd MMM yy"
            titleLbl = df.string(from: (dateModelObject.value.date!))
        }
        
        df.dateFormat = "dd MMM"
        let currDate = df.string(from: (currentDate))
        if currDate == titleLbl{
            titleLbl = "Hari Ini"
        }
        tanggalModelObject.accept(changeDateIntoYYYYMMDD(dateModelObject.value.date!))
        titleDateModelObject.accept(titleLbl)
    }

    //MARK: - OBJECT DECLARATION
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func fetchMonitoring() async {
        let endpoint = ApplicationEndpoint.getMonitoringByDate(userID: userID, date: tanggalEndpointModelObject.value)
        let result = await networkService.request(to: endpoint, decodeTo: Response<[Monitoring]>.self)
        switch result {
        case .success(let response):
            if let monitoring = response.data {
                self.monitoringModelArray.accept(monitoring)
            }
        case .failure(let error):
            print(error)
        }
    }
}
