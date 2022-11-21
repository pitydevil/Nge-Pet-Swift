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
    private var genericHandlingErrorObject = BehaviorRelay<genericHandlingError>(value: .success)
    private var monitoringEnumCaseModel    = BehaviorRelay<monitoringCase>(value: .empty)
    var orderStatusObject = BehaviorRelay<String>(value: String())
    
    //MARK: - OBJECT OBSERVER DECLARATION
    var orderModelArrayObserver   : Observable<[Order]> {
        return orderModelArray.asObservable()
    }

    var monitoringEnumCaseObserver : Observable<monitoringCase> {
        return monitoringEnumCaseModel.asObservable()
    }
    var genericHandlingErrorObserver   : Observable<genericHandlingError> {
        return genericHandlingErrorObject.asObservable()
    }

    //MARK: - INIT OBJECT DECLARATION
    init(networkService: NetworkServicing = NetworkService()) {
        self.networkService = networkService
    }
    
    //MARK: - Init Object Declaration
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func checkOrderController(_ order : [Order]) {
        order.isEmpty ? monitoringEnumCaseModel.accept(.empty) : monitoringEnumCaseModel.accept(.terisi)
    }
    
    //MARK: - OBJECT DECLARATION
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func fetchOrderList() async {
        let endpoint = ApplicationEndpoint.getOrderList(orderStatus: orderStatusObject.value, userID: userID)
        let result = await networkService.request(to: endpoint, decodeTo: Response<[Order]>.self)
        switch result {
        case .success(let response):
            genericHandlingErrorObject.accept(genericHandlingError(rawValue: response.status!)!)
            if let order = response.data {
                self.orderModelArray.accept(order)
            }
        case .failure(_):
            genericHandlingErrorObject.accept(genericHandlingError(rawValue: 500)!)
        }
    }
}
