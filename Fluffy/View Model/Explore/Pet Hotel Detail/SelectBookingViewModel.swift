//
//  SelectBookingViewModel.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 15/11/22.
//

import Foundation
import RxSwift
import RxCocoa

class SelectBookingViewModel {
    
    //MARK: OBJECT DECLARATION
    private var provider             = BaseProviders()
    private let networkService       : NetworkServicing
    private var petArray             : Observable<[Pets]>?
    private let petModelObjectArray  = BehaviorRelay<[OrderDetailBody]>(value: [])
    private var monitoringEnumCaseModel    = BehaviorRelay<monitoringCase>(value: .empty)

    //MARK: OBJECT OBSERVER DECLARATION
    var petModelObjectArrayObserver: Observable<[OrderDetailBody]> {
        return petModelObjectArray.asObservable()
    }
    
    var monitoringEnumCaseObserver : Observable<monitoringCase> {
        return monitoringEnumCaseModel.asObservable()
    }
    
    //MARK: - INIT OBJECT
    init(networkService: NetworkServicing = NetworkService()) {
        self.networkService = networkService
        self.provider =  BaseProviders()
    }
    
    //MARK: - Init Object Declaration
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func checkPetsController(_ pet : [OrderDetailBody]) {
        pet.isEmpty ? monitoringEnumCaseModel.accept(.empty) : monitoringEnumCaseModel.accept(.terisi)
    }
    
    //MARK: - INIT OBJECT
    /// Retujrn NULL
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func getAllPet() {
        petArray = provider.callDatabase()
        petArray?.subscribe(onNext: { (value) in
            var petModel = [OrderDetailBody]()
            for pet in value {
                petModel.append(OrderDetailBody(petName: pet.petName!, petType: pet.petType!, petSize: pet.petSize!, petData: pet.petData!, packagename: "",packageID: -1, orderDetailPrice: 0, isExpanded: false, customSOP: [CustomSopBody]()))
            }
            self.petModelObjectArray.accept(petModel)
        }, onError: { (error) in
            _ = self.petModelObjectArrayObserver.catch { (error) in
                Observable.empty()
            }
        }).disposed(by: bags)
    }
    
    //MARK: - OBJECT DECLARATION
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
//    func fetchMonitoring() async {
//        let endpoint = ApplicationEndpoint.getListMonitoring(MonitoringBody: monitoringBodyModelObject.value)
//        let result = await networkService.request(to: endpoint, decodeTo: Response<[Monitoring]>.self)
//        switch result {
//        case .success(let response):
//            if let monitoring = response.data {
//                self.monitoringModelArray.accept(monitoring)
//            }
//        case .failure(let error):
//            print(error)
//        }
//    }
}
