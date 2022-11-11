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
    private var LocationManager : LocationManager
    private let networkService       : NetworkServicing
    private let petHotelModelArray   = BehaviorRelay<[PetHotels]>(value: [])
    
    //MARK: - OBSERVABLE OBJECT DECLARATION
    var locationObject               = BehaviorRelay<Location>(value: Location(longitude: 0.0, latitude: 0.0))
    var petHotelModelArrayObserver   : Observable<[PetHotels]> {
        return petHotelModelArray.asObservable()
    }

    //MARK: - INIT OBJECT
    init(networkService: NetworkServicing = NetworkService(), locationManager : LocationManager) {
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
