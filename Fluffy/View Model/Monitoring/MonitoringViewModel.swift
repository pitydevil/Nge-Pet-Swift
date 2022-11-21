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
    private let networkService       : NetworkServicing
    private var provider = BaseProviders()
    private var monitoringModelArray = BehaviorRelay<[Monitoring]>(value: [])
    private var petArray: Observable<[Pets]>?
    private var genericHandlingErrorObject = BehaviorRelay<genericHandlingError>(value: .success)
    private var monitoringEnumCaseModel    = BehaviorRelay<monitoringCase>(value: .empty)
    private let petModelArray = BehaviorRelay<[PetsSelection]>(value: [])
    var petSelection          = BehaviorRelay<[PetsSelection]>(value: [])
    var petBody               = BehaviorRelay<[PetBody]>(value: [])
    var dateModelObject       = BehaviorRelay<DateComponents>(value: DateComponents())
    var titleDateModelObject  = BehaviorRelay<String>(value: String())
    var tanggalModelObject    = BehaviorRelay<String>(value: String())
    var jumlahHewanObject     = BehaviorRelay<String>(value: String())
    var monitoringBodyModelObject   = BehaviorRelay<MonitoringBody>(value: MonitoringBody(userID: 1, date: "", pets: [PetBody]()))
    
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
    
    var petModelArrayObserver: Observable<[PetsSelection]> {
        return petModelArray.asObservable()
    }
    
    var jumlahHewanObjectObserver: Observable<String> {
        return jumlahHewanObject.asObservable()
    }
    
    var genericHandlingErrorObserver   : Observable<genericHandlingError> {
        return genericHandlingErrorObject.asObservable()
    }
    var monitoringEnumCaseObserver : Observable<monitoringCase> {
        return monitoringEnumCaseModel.asObservable()
    }
    
    
    //MARK: - INIT OBJECT
    init(networkService: NetworkServicing = NetworkService()) {
        self.networkService = networkService
        self.provider =  BaseProviders()
    }
    
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func getAllPet() {
        petArray = provider.callDatabase()
        petArray?.subscribe(onNext: { (value) in
            var petModel = [PetsSelection]()
            for pet in value {
                petModel.append(PetsSelection(petID: pet.petID, petData: pet.petData, petAge: Int(pet.petAge!), petBreed: pet.petBreed, petName: pet.petName, petSize: pet.petSize, petType: pet.petType, petGender: pet.petGender, dateCreated: pet.dateCreated, isChecked: false))
            }
            self.petModelArray.accept(petModel)
        }, onError: { (error) in
            _ = self.petModelArrayObserver.catch { (error) in
                Observable.empty()
            }
        }).disposed(by: bags)
    }
    
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func checkPetStateController(_ monitoringArray : [Monitoring]) {
        monitoringArray.isEmpty ? monitoringEnumCaseModel.accept(.empty) : monitoringEnumCaseModel.accept(.terisi)
    }
    
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
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
    func configureHewanCounterLabel() {
        if petBody.value.count == petSelection.value.count {
            jumlahHewanObject.accept("Semua Hewan")
        }else {
            jumlahHewanObject.accept("\(petBody.value.count) hewan dipilih")
        }
    }
    
    //MARK: - OBJECT DECLARATION
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func fetchMonitoring() async {
        let endpoint = ApplicationEndpoint.getListMonitoring(MonitoringBody: monitoringBodyModelObject.value)
        let result = await networkService.request(to: endpoint, decodeTo: Response<[Monitoring]>.self)
        switch result {
        case .success(let response):
            genericHandlingErrorObject.accept(genericHandlingError(rawValue: response.status!)!)
            if let monitoring = response.data {
                self.monitoringModelArray.accept(monitoring)
            }
        case .failure(_):
            genericHandlingErrorObject.accept(genericHandlingError(rawValue: 500)!)
        }
    }
}
