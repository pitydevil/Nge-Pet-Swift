//
//  BookingConfirmationViewModel.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 16/11/22.
//

import Foundation
import RxSwift
import RxCocoa

class BookingConfirmationViewModel {
    //MARK: - OBJECT DECLARATION
    private let networkService    : NetworkServicing
    let orderAddModel   = BehaviorRelay<OrderAdd>(value:OrderAdd(orderDateCheckIn: "", orderDateCheckOu: "", orderTotalPrice: 0, userID: userID, petHotelId: 0, orderDetails: [OrderDetailBodyFinal]()))
    
    //MARK: - OBJECT OBSERVER DECLARATION
    private var genericHandlingErrorObject = BehaviorRelay<genericHandlingError>(value: .success)
    
    var genericHandlingErrorObserver   : Observable<genericHandlingError> {
        return genericHandlingErrorObject.asObservable()
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
    func postOrderAdd() async {
        let endpoint = ApplicationEndpoint.getOrderAdd(order: orderAddModel.value)
        let result = await networkService.request(to: endpoint, decodeTo: Response<EmptyData>.self)
        switch result {
        case .success(let response):
            genericHandlingErrorObject.accept(genericHandlingError(rawValue: response.status!)!)
        case .failure(_):
            genericHandlingErrorObject.accept((genericHandlingError(rawValue: 500)!))
        }
    }
}
