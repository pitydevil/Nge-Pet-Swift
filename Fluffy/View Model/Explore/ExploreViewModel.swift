//
//  ExploreViewModel.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 09/11/22.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

class ExploreViewModel{

    //MARK: - OBJECT DECLARATION
    private var LocationManager            : LocationManager
    private let networkService             : NetworkServicing
    private var provider                   = BaseProviders()
    private let petHotelModelArray         = BehaviorRelay<[PetHotels]>(value: [])
    private let searchPetHotelModelArray   = BehaviorRelay<[PetHotels]>(value: [])
    private var petArray: Observable<[Pets]>?
    private let petModelArray   = BehaviorRelay<[PetsSelection]>(value: [])
    var petSelection            = BehaviorRelay<[PetsSelection]>(value: [])
    var petBody                 = BehaviorRelay<[PetBody]>(value: [])
    var jumlahHewanObject       = BehaviorRelay<String>(value: String())
    var exploreSearchBodyObject = BehaviorRelay<ExploreSearchBody>(value: ExploreSearchBody(longitude: 0.0, latitude: 0.0, checkInDate: "", checkOutDate: "", pets: [PetBody]()))
    
    //MARK: - OBSERVABLE OBJECT DECLARATION
    var locationObject               = BehaviorRelay<Location>(value: Location(longitude: 0.0, latitude: 0.0))
    
    var petHotelModelArrayObserver   : Observable<[PetHotels]> {
        return petHotelModelArray.asObservable()
    }
    
    var searchPetHotelModelArrayObserver   : Observable<[PetHotels]> {
        return searchPetHotelModelArray.asObservable()
    }
    
    var petModelArrayObserver: Observable<[PetsSelection]> {
        return petModelArray.asObservable()
    }
    
    var jumlahHewanObjectObserver: Observable<String> {
        return jumlahHewanObject.asObservable()
    }

    //MARK: - INIT OBJECT
    init(networkService: NetworkServicing = NetworkService(), locationManager : LocationManager) {
        self.provider =  BaseProviders()
        self.networkService = networkService
        self.LocationManager = locationManager
        
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        locationManager.locationObjectObserver.subscribe(onNext: { [self] (value) in
            locationObject.accept(value)
        },onError: { error in
          print(error)
        }).disposed(by: bags)
        
        defaults.setValue(1, forKey: "userID")
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
    
    //MARK: - OBJECT DECLARATION
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func fetchSearchExploreList() async {
        let endpoint = ApplicationEndpoint.getSearchListPetHotel(exploreSearchBody: exploreSearchBodyObject.value)
        let result = await networkService.request(to: endpoint, decodeTo: Response<[PetHotels]>.self)
        switch result {
        case .success(let response):
            if let petHotel = response.data {
                self.searchPetHotelModelArray.accept(petHotel)
            }
        case .failure(let error):
            print(error)
        }
    }
    
    //MARK: - OBJECT DECLARATION
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func fetchExploreList() async {
        let endpoint = ApplicationEndpoint.getNearest(longitude: locationObject.value.longitude, latitude: locationObject.value.latitude)
        let result = await networkService.request(to: endpoint, decodeTo: Response<[PetHotels]>.self)
        switch result {
        case .success(let response):
            if let petHotel = response.data {
                self.petHotelModelArray.accept(petHotel)
            }
        case .failure(let error):
            print(error)
        }
    }
}
