//
//  PetHotelPackageViewModel.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 13/11/22.
//

import Foundation
import RxCocoa
import RxSwift

struct PetHotelPackageViewModel {
    //MARK: - OBJECT DECLARATION
    private let networkService       : NetworkServicing
    private var petHotelPackageModel = BehaviorRelay<[PetHotelPackage]>(value: [])
    var petHotelID                   = BehaviorRelay<Int>(value: 0)
    var supportedPetName             = BehaviorRelay<String>(value: "")
    
    //MARK: - OBSERVABLE OBJECT DECLARATION
    var petHotelPackageModelArrayObserver : Observable<[PetHotelPackage]> {
        return petHotelPackageModel.asObservable()
    }
    
    //MARK: - INIT OBJECT
    init(networkService: NetworkServicing = NetworkService()) {
        self.networkService = networkService
    }
    
    //MARK: - OBJECT DECLARATION
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func fetchPetHotelPackage() async {
        let endpoint = ApplicationEndpoint.getPetHotelPackage(petHotelID: petHotelID.value, supportedPetName: supportedPetName.value)
        let result = await networkService.request(to: endpoint, decodeTo: Response<[PetHotelPackage]>.self)
        switch result {
        case .success(let response):
            if let petHotelPackage = response.data {
                self.petHotelPackageModel.accept(petHotelPackage)
            }
        case .failure(let error):
            print(error)
        }
    }
}
