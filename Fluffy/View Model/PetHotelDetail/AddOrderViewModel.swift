//
//  AddOrderViewModel.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 10/11/22.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

class AddOrderViewModel{

    //MARK: - OBJECT DECLARATION
    private let networkService       : NetworkServicing
    private let AddOrderArray   = BehaviorRelay<[AddOrder]>(value: [])
    
    //MARK: - OBSERVABLE OBJECT DECLARATION
    var AddOrderArrayObserver   : Observable<[AddOrder]> {
        return AddOrderArray.asObservable()
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
//    func addOrder() async {
//        let endpoint = ApplicationEndpoint.postOrder(order: AddOrderArray.value)
//        let result = await networkService.request(to: endpoint, decodeTo: Response<[OrderResponse]>.self)
//        switch result {
//        case .success(let response):
//            if case 200 = response.status {
//               print("success")
//            }
//        case .failure(let error):
//            print(error)
//        }
//    }
}
