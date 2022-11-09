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
    private let orderModelArray   = BehaviorRelay<[Order]>(value: [])
    var orderStatusObject = BehaviorRelay<String>(value: String())
    var orderModelArrayObserver   : Observable<[Order]> {
        return orderModelArray.asObservable()
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
    func fetchOrderList() async {
        let endpoint = ApplicationEndpoint.getOrderList(orderStatus: orderStatusObject.value)
        let result = await networkService.request(to: endpoint, decodeTo: Response<[Order]>.self)
        switch result {
        case .success(let response):
            if let order = response.data {
                self.orderModelArray.accept(order)
            }
        case .failure(let error):
            print(error)
        }
    }
}
