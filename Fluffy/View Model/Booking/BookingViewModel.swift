//
//  BookingViewModel.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 08/11/22.
//

import Foundation
import RxSwift
import RxCocoa

class BookingViewModel {
    
    //MARK: - OBJECT DECLARATION
    private let networkService    : NetworkServicing
    private let exploreModelArray   = BehaviorRelay<[PetHotels]>(value: [])
    var exploreStatusObject = BehaviorRelay<String>(value: String())
    var exploreModelArrayObserver   : Observable<[PetHotels]> {
        return exploreModelArray.asObservable()
    }

    init(networkService: NetworkServicing = NetworkService()) {
        self.networkService = networkService
    }
    
    //MARK: - OBJECT DECLARATION
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func fetchExploreList() async {
        let endpoint = ApplicationEndpoint.getExploreList(exploreStatus: exploreStatusObject.value)
        let result = await networkService.request(to: endpoint, decodeTo: Response<[PetHotels]>.self)
        switch result {
        case .success(let response):
            if let explore = response.data {
                self.exploreModelArray.accept(explore)
            }
        case .failure(let error):
            print(error)
        }
    }
}
